//
//  HomeViewController.swift
//  AlbumList
//
//  Created by Bowie Tso on 29/3/2023.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: BaseViewController {

    @IBOutlet weak var searchBarContainerView: UIView!
    @IBOutlet weak var searchBarTextField: UITextField!
    @IBOutlet weak var cancelButtonContainerView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var albumListCollectionView: UICollectionView!
    
    let viewModel = HomeViewControllerViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewAndSearchBar()
        setupBinding()
        cancelButton.setTitle("", for: .normal)
        cancelButton.imageView?.tintColor = .darkGray
        viewModel.callApiForAlbumList(keyword: viewModel.searchBarKeyowrd.value).disposed(by: disposeBag)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
    }
    
    func setupCollectionViewAndSearchBar() {
        albumListCollectionView.delegate = self
        albumListCollectionView.dataSource = self
        albumListCollectionView.register(UINib(resource: R.nib.albumCollectionViewCell),
                                         forCellWithReuseIdentifier: R.reuseIdentifier.albumCollectionViewCell.identifier)
        searchBarTextField.delegate = self
        searchBarTextField.text = viewModel.searchBarKeyowrd.value
        
    }
    
    func setupBinding() {
        viewModel.albumList.bind { [weak self] (list) in
            guard let self = self else {return}
            self.albumListCollectionView.reloadData()
        }.disposed(by: disposeBag)
        
        self.searchBarTextField.rx.controlEvent([.editingDidBegin]).bind{[weak self] (isEditing) in
            guard let self = self else {return}
            self.cancelButtonContainerView.isHidden = false
        }.disposed(by: disposeBag)
        
        self.searchBarTextField.rx.controlEvent([.editingDidEnd]).asObservable().bind {[weak self] _ in
            guard let self = self else {return}
            self.cancelButtonContainerView.isHidden = true
        }.disposed(by: disposeBag)
        
        searchBarTextField.rx
            .controlEvent([.editingChanged])
            .subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                self.viewModel.searchBarKeyowrd.accept(self.searchBarTextField.text ?? "")
            }).disposed(by: disposeBag)
    }


    @IBAction func didCancelButtonTapped(_ sender: Any) {
        searchBarTextField.endEditing(true)
    }
}

extension HomeViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        viewModel.callApiForAlbumList(keyword: viewModel.searchBarKeyowrd.value).disposed(by: disposeBag)
        searchBarTextField.endEditing(true)
        return true
    }
    
}


extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.albumList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.albumCollectionViewCell, for: indexPath) as! AlbumCollectionViewCell
        cell.setup(viewModel: AlbumCollectionViewCellViewModel(model: viewModel.albumList.value[indexPath.row]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = viewModel.albumList.value[indexPath.row]
        let vc = R.storyboard.home.albumDetailViewController()!
        vc.viewModel.setupVm(model: model)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

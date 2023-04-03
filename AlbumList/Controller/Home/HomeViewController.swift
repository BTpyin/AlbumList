//
//  HomeViewController.swift
//  AlbumList
//
//  Created by Bowie Tso on 29/3/2023.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftyUserDefaults
import SnapKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var searchBarContainerView: UIView!
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var favouriteImageView: UIImageView!
    @IBOutlet weak var searchBarTextField: UITextField!
    @IBOutlet weak var cancelButtonContainerView: UIView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var albumListCollectionView: UICollectionView!
    
    @IBOutlet weak var searchNoResultView: UIView!
    @IBOutlet weak var selectedFavouriteAlbumImageView: UIImageView!
    @IBOutlet weak var animatedFavouriteAlbumView: UIView!
    let viewModel = HomeViewControllerViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        animatedFavouriteAlbumView.dropShadow(color: .black, opacity: 0.15, offSet: .zero, radius: 2)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionViewAndSearchBar()
        setupSaveForLaterAnimatedImage()
        setupBinding()
        viewModel.callApiForAlbumList(keyword: viewModel.searchBarKeyowrd.value).disposed(by: disposeBag)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar()
        albumListCollectionView.reloadData()
    }
    
    private func setupCollectionViewAndSearchBar() {
        albumListCollectionView.delegate = self
        albumListCollectionView.dataSource = self
        albumListCollectionView.register(UINib(resource: R.nib.albumCollectionViewCell),
                                         forCellWithReuseIdentifier: R.reuseIdentifier.albumCollectionViewCell.identifier)
        searchBarTextField.delegate = self
        searchBarTextField.text = viewModel.searchBarKeyowrd.value
        
        favouriteImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(didFavouriteImageTapped)))
        favouriteImageView.isUserInteractionEnabled = true
    }
    
    private func setupSaveForLaterAnimatedImage() {
        
        animatedFavouriteAlbumView.isHidden = true
        
        animatedFavouriteAlbumView.snp.makeConstraints{(maker) in
            maker.centerX.equalTo(favouriteImageView.snp.centerX)
            maker.top.equalTo(titleView.snp.bottom).offset(5)
        }
    }
    
    
    private func setupBinding() {
        viewModel.albumList.bind { [weak self] (list) in
            guard let self = self else {return}
            self.albumListCollectionView.reloadData()
            self.albumListCollectionView.safeScrollToItem(at: .init(row: 0, section: 0), at: .top, animated: true)
            self.searchNoResultView.isHidden = (list.count > 0)
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
        
        viewModel.selectedImageUrl.bind(to: selectedFavouriteAlbumImageView.rx.imageURL).disposed(by: disposeBag)
    }
    
    private func displaySaveToFavouriteAnimation() {
        
        let imageYposition = self.titleView.center.y + self.titleView.size.height/2 + 5 + self.animatedFavouriteAlbumView.frame.size.height/2
        
        self.animatedFavouriteAlbumView.snp.remakeConstraints{(maker) in
            maker.centerX.equalTo(self.favouriteImageView.snp.centerX)
            maker.top.equalTo(titleView.snp.bottom).offset(5)
        }
        
        let xMove = 0.0
        let yMove = (self.titleView.center.y - imageYposition)
        self.animatedFavouriteAlbumView.isHidden = false
        
        print("image move(X) \(xMove) pixel")
        print("image move(Y) \(yMove) pixel")

        UIView.animate(withDuration: 1, delay: 0.25, options: [], animations: {
            
            self.animatedFavouriteAlbumView.transform = CGAffineTransform(translationX: xMove, y: yMove).scaledBy(x: 0.5, y: 0.5)//Move to new center point
            
        },completion: { finish in
            self.animatedFavouriteAlbumView.isHidden = true
            self.animatedFavouriteAlbumView.transform = .identity
            
        })
        
    }
    
    @IBAction func didCancelButtonTapped(_ sender: Any) {
        searchBarTextField.endEditing(true)
    }
    
    @objc func didFavouriteImageTapped() {
        let vc = R.storyboard.home.favouriteListViewController()!
        navigationController?.pushViewController(vc, animated: true)
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        searchBarTextField.endEditing(true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.albumList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.reuseIdentifier.albumCollectionViewCell, for: indexPath)!
        cell.setup(viewModel: AlbumCollectionViewCellViewModel(model: viewModel.albumList.value[indexPath.row]))
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let model = viewModel.albumList.value[indexPath.row]
        let vc = R.storyboard.home.albumDetailViewController()!
        vc.viewModel.setupVm(model: model)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

extension HomeViewController: AlbumCollectionViewCellDelegate {
    
    func didFavouriteViewTapped(collectionId: Int) {
        if FavouriteHelper.getFavouriteAlbum(by: collectionId) != nil{
            FavouriteHelper.removeFavouriteAlbum(by: collectionId)
        } else {
            if let selectedAlbum = viewModel.albumList.value.filter({$0.collectionID == collectionId}).first {
                FavouriteHelper.setOrAddNewFavouriteAlbum(album: selectedAlbum)
                viewModel.selectedImageUrl.accept(selectedAlbum.artworkUrl100 ?? "")
                displaySaveToFavouriteAnimation()
            }
        }
    }
}

extension HomeViewController: AlbumDetailViewControllerDeletgate {
    
    func didDetailPageIsFavouriteTapped(collectionId: Int) {
        if FavouriteHelper.getFavouriteAlbum(by: collectionId) != nil{
            FavouriteHelper.removeFavouriteAlbum(by: collectionId)
        } else {
            if let selectedAlbum = viewModel.albumList.value.filter({$0.collectionID == collectionId}).first {
                FavouriteHelper.setOrAddNewFavouriteAlbum(album: selectedAlbum)
            }
        }
        //        albumListCollectionView.reloadData()
    }
}

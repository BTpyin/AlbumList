//
//  FavouriteListViewController.swift
//  AlbumList
//
//  Created by Bowie Tso on 2/4/2023.
//

import UIKit
import RxCocoa
import RxSwift

class FavouriteListViewController: BaseViewController {

    @IBOutlet weak var favouriteListTableView: UITableView!
    @IBOutlet weak var favouriteListEmptyView: UIView!
    
    private var favouriteListOptionsAlertController: UIAlertController?
    
    let viewModel = FavouriteListViewControllerViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(.backWithTitle(title: localized.favourite_album_title.string()))
        favouriteListTableView.delegate = self
        favouriteListTableView.dataSource = self
        favouriteListTableView.register(UINib(resource: R.nib.favouriteListTableViewCell),
                                       forCellReuseIdentifier: R.reuseIdentifier.favouriteListTableViewCell.identifier)
        setupBinding()
        // Do any additional setup after loading the view.
    }
    
    func setupBinding() {
        viewModel.favouriteAlbumList.bind { [weak self] (list) in
            guard let self = self else {return}
            self.favouriteListTableView.reloadData()
            self.favouriteListEmptyView.isHidden = (list.count > 0)
        }.disposed(by: disposeBag)
    }
    
    func setupFavouriteListOptionsAlertAndDisplay(collectionId: Int){
        let alertController = UIAlertController(title: nil,
                                                message: nil,
                                                preferredStyle: .actionSheet)
        alertController.overrideUserInterfaceStyle = .light
        
        let removeFavouriteAction = UIAlertAction(title: localized.favourite_album_title_remove.string(),
                                                style: .default,
                                         handler: {[weak self] (action) in
            guard let self = self else {return}
            if FavouriteHelper.getFavouriteAlbum(by: collectionId) != nil{
                FavouriteHelper.removeFavouriteAlbum(by: collectionId)
            }
            self.viewModel.fetchFavouriteAlbumList()
        })
        
        removeFavouriteAction.setValue(UIColor.red, forKey: "titleTextColor")
        
        let cancelAction = UIAlertAction(title: localized.cancel.string(),
                                         style: .cancel)
        
        alertController.addAction(removeFavouriteAction)
        alertController.addAction(cancelAction)
        favouriteListOptionsAlertController = alertController
        present(favouriteListOptionsAlertController!,
                animated: true,
                completion: nil)
    }
    
}

extension FavouriteListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favouriteAlbumList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.favouriteListTableViewCell, for: indexPath)!
        cell.viewModel.setupVm(model: viewModel.favouriteAlbumList.value[indexPath.row])
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let model = viewModel.favouriteAlbumList.value[indexPath.row]
        let vc = R.storyboard.home.albumDetailViewController()!
        vc.viewModel.setupVm(model: model)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

extension FavouriteListViewController: FavouriteListTableViewCellDeletgate {
    func didTapMoreButton(collectionId: Int) {
        setupFavouriteListOptionsAlertAndDisplay(collectionId: collectionId)
    }
}



extension FavouriteListViewController: AlbumDetailViewControllerDeletgate {
    
    func didDetailPageIsFavouriteTapped(collectionId: Int) {
        if FavouriteHelper.getFavouriteAlbum(by: collectionId) != nil{
            FavouriteHelper.removeFavouriteAlbum(by: collectionId)
        } else {
            if let selectedAlbum = viewModel.favouriteAlbumList.value.filter({$0.collectionID == collectionId}).first {
                FavouriteHelper.setOrAddNewFavouriteAlbum(album: selectedAlbum)
            }
        }
        viewModel.fetchFavouriteAlbumList()
    }
}

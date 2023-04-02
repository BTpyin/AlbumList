//
//  FavouriteListViewController.swift
//  AlbumList
//
//  Created by Bowie Tso on 2/4/2023.
//

import UIKit
import RxCocoa
import RxSwift

class FavouriteListViewController: UIViewController {

    @IBOutlet weak var favouriteListTableView: UITableView!
    
    let viewModel = FavouriteListViewControllerViewModel()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar(.backWithTitle(title: "Favourite Album"))
        favouriteListTableView.delegate = self
        favouriteListTableView.dataSource = self
        favouriteListTableView.register(UINib(resource: R.nib.favouriteListTableViewCell),
                                       forCellReuseIdentifier: R.reuseIdentifier.favouriteListTableViewCell.identifier)
        setupBinding()
        // Do any additional setup after loading the view.
    }
    
    func setupBinding() {
        viewModel.favouriteAlbumList.bind { [weak self] _ in
            guard let self = self else {return}
            self.favouriteListTableView.reloadData()
        }.disposed(by: disposeBag)
    }
    
}

extension FavouriteListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.favouriteAlbumList.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.favouriteListTableViewCell, for: indexPath)!
        cell.viewModel.setupVm(model: viewModel.favouriteAlbumList.value[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = viewModel.favouriteAlbumList.value[indexPath.row]
        let vc = R.storyboard.home.albumDetailViewController()!
        vc.viewModel.setupVm(model: model)
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
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

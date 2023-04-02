//
//  FavouriteListViewControllerViewModel.swift
//  AlbumList
//
//  Created by Bowie Tso on 2/4/2023.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyUserDefaults

struct FavouriteListViewControllerViewModel {
    
    let favouriteAlbumList = BehaviorRelay<AlbumList>(value: [])
    init() {
        fetchFavouriteAlbumList()
    }
    
    func fetchFavouriteAlbumList() {
        favouriteAlbumList.accept(Defaults[\.favourite_albums] ?? [])
    }
}

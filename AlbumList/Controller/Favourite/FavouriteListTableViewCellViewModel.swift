//
//  FavouriteListTableViewCellViewModel.swift
//  AlbumList
//
//  Created by Bowie Tso on 2/4/2023.
//

import Foundation
import RxCocoa
import RxSwift

struct FavouriteListTableViewCellViewModel {
    
    let collectionId = BehaviorRelay<Int>(value: 0)
    let albumImageUrl = BehaviorRelay<String>(value: "")
    let collectionName = BehaviorRelay<String>(value: "")
    let artistName = BehaviorRelay<String>(value: "")
    
    func setupVm(model: Album) {
        collectionId.accept(model.collectionID ?? 0)
        albumImageUrl.accept(model.artworkUrl100 ?? "")
        collectionName.accept(model.collectionName ?? "")
        artistName.accept(model.artistName ?? "")
    }
}

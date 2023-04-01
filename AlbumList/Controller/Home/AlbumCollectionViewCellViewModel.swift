//
//  AlbumCollectionViewCellViewModel.swift
//  AlbumList
//
//  Created by Bowie Tso on 31/3/2023.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyUserDefaults

struct AlbumCollectionViewCellViewModel {
    
    let collectionId = BehaviorRelay<Int>(value: 0)
    let albumImageUrl = BehaviorRelay<String>(value: "")
    let collectionName = BehaviorRelay<String>(value: "")
    let artistName = BehaviorRelay<String>(value: "")
    let copyrightText = BehaviorRelay<String?>(value: "")
    let isFavourite = BehaviorRelay<Bool>(value: false)
    
    init() {}
    
    init(model: Album) {
        collectionId.accept(model.collectionID ?? 0)
        albumImageUrl.accept(model.artworkUrl100 ?? "")
        collectionName.accept(model.collectionName ?? "")
        artistName.accept(model.artistName ?? "")
        copyrightText.accept(model.copyright ?? "")
        if FavouriteHelper.getFavouriteAlbum(by: model.collectionID) != nil {
            isFavourite.accept(true)
        } else {
            isFavourite.accept(false)
        }
        
        
    }
    
}

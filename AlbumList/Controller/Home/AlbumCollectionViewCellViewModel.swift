//
//  AlbumCollectionViewCellViewModel.swift
//  AlbumList
//
//  Created by Bowie Tso on 31/3/2023.
//

import Foundation
import RxSwift
import RxCocoa

struct AlbumCollectionViewCellViewModel {
    
    let albumImageUrl = BehaviorRelay<String>(value: "")
    let collectionName = BehaviorRelay<String>(value: "")
    let artistName = BehaviorRelay<String>(value: "")
    let copyrightText = BehaviorRelay<String?>(value: "")
    
    init() {}
    
    init(model: Album) {
        albumImageUrl.accept(model.artworkUrl100 ?? "")
        collectionName.accept(model.collectionName ?? "")
        artistName.accept(model.artistName ?? "")
        copyrightText.accept(model.copyright ?? "")
    }
    
}

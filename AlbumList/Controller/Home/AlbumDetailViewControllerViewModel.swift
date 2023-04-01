//
//  AlbumDetailViewControllerViewModel.swift
//  AlbumList
//
//  Created by Bowie Tso on 31/3/2023.
//

import Foundation
import RxCocoa
import RxSwift

struct AlbumDetailViewControllerViewModel {
    
    let albumImageUrl = BehaviorRelay<String>(value: "")
    let collectionName = BehaviorRelay<String>(value: "")
    let artistName = BehaviorRelay<String>(value: "")
    let copyrightText = BehaviorRelay<String>(value: "")
    let releaseDate = BehaviorRelay<String>(value: "")
    let genre = BehaviorRelay<String>(value: "")
    let noOfTrack = BehaviorRelay<String>(value: "")
    let country = BehaviorRelay<String>(value: "")
    let price = BehaviorRelay<String>(value: "")
    
    let albumUrl = BehaviorRelay<String>(value: "")
    let artistUrl = BehaviorRelay<String>(value: "")
    
    func setupVm(model: Album) {
        albumImageUrl.accept(model.artworkUrl100 ?? "")
        collectionName.accept(model.collectionName ?? "")
        artistName.accept(model.artistName ?? "")
        copyrightText.accept(model.copyright ?? "")
//        releaseDate.accept(model.releaseDate ?? "")
        genre.accept(model.primaryGenreName ?? "")
        noOfTrack.accept((model.trackCount ?? 0).string)
        price.accept(String(format: "$%.2f", (model.collectionPrice ?? 0.0)))
        albumUrl.accept(model.collectionViewURL ?? "")
        artistUrl.accept(model.artistViewURL ?? "")
                     
        
        
    }
    
    
}

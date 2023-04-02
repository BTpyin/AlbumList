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
    
    let collectionId = BehaviorRelay<Int>(value: 0)
    
    let albumImageUrl = BehaviorRelay<String>(value: "")
    let collectionName = BehaviorRelay<String>(value: "")
    let artistName = BehaviorRelay<String>(value: "")
    let copyrightText = BehaviorRelay<String>(value: "")
    let releaseDate = BehaviorRelay<String>(value: "")
    let genre = BehaviorRelay<String>(value: "")
    let noOfTrack = BehaviorRelay<String>(value: "")
    let country = BehaviorRelay<String>(value: "")
    let price = BehaviorRelay<String>(value: "")
    
    let isFavourite = BehaviorRelay<Bool>(value: false)
    
    let albumUrl = BehaviorRelay<String>(value: "")
    let artistUrl = BehaviorRelay<String>(value: "")
    
    func setupVm(model: Album) {
        
        collectionId.accept(model.collectionID ?? 0)
        
        albumImageUrl.accept(model.artworkUrl100 ?? "")
        collectionName.accept(model.collectionName ?? "")
        artistName.accept(model.artistName ?? "")
        copyrightText.accept(model.copyright ?? "")
        country.accept(model.country ?? "")
        releaseDate.accept(model.releaseDate?.string(withFormat: "YYYY/MM/dd") ?? "")
        genre.accept(model.primaryGenreName ?? "")
        noOfTrack.accept((model.trackCount ?? 0).string)
        price.accept(String(format: "$%.2f", (model.collectionPrice ?? 0.0)))
        albumUrl.accept(model.collectionViewURL ?? "")
        artistUrl.accept(model.artistViewURL ?? "")
                     
        if FavouriteHelper.getFavouriteAlbum(by: model.collectionID) != nil {
            isFavourite.accept(true)
        } else {
            isFavourite.accept(false)
        }
        
    }
    
    
}

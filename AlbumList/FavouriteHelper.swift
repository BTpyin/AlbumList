//
//  FavouriteHelper.swift
//  AlbumList
//
//  Created by Bowie Tso on 1/4/2023.
//

import Foundation
import SwiftyUserDefaults
struct FavouriteHelper {
    
    static func getFavouriteAlbum(by collectionId: Int?) -> Album? {
        if let collectionId = collectionId,
           let albumList = Defaults[\.favourite_albums] {
            return albumList.first(where: { $0.collectionID == collectionId })
        } else {
            return nil
        }
    }
    
    static func add(album: Album) {
        if let _ = Defaults[\.favourite_albums] {
            Defaults[\.favourite_albums]?.append(album)
        } else {
            Defaults[\.favourite_albums] = [album]
        }
    }
    
    static func setOrAddNewFavouriteAlbum(album: Album) {
        guard let collectionId = album.collectionID else { return }
        
        if let albumList = Defaults[\.favourite_albums], let index = albumList.firstIndex(where: { $0.collectionID == collectionId} ) {
            Defaults[\.favourite_albums]?[index] = album
        } else {
            add(album: album)
        }
    }
    
    static func removeFavouriteAlbum(by collectionId: Int) {
        if let albumList = Defaults[\.favourite_albums], let index = albumList.firstIndex(where: { $0.collectionID == collectionId} ) {
            Defaults[\.favourite_albums]?.remove(at: index)
        }
    }
}

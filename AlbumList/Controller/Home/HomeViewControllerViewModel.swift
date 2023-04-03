//
//  HomeViewControllerViewModel.swift
//  AlbumList
//
//  Created by Bowie Tso on 30/3/2023.
//

import Foundation
import RxSwift
import RxCocoa

struct HomeViewControllerViewModel {
    
    let isLoading = BehaviorRelay<Bool>(value: true)
    let albumList = BehaviorRelay<AlbumList>(value: [])
    let searchBarKeyowrd = BehaviorRelay<String?>(value: "Jack Johnson")
    
    let selectedImageUrl = BehaviorRelay<String>(value: "")
    
    func callApiForAlbumList(keyword: String?) -> Disposable {
        return NetworkManager.requestAPI(target: .search(keyword: keyword?.removeSpaceForKeywordSearch() ?? ""), type: AlbumList?.self)
            .mapAPIObject(element: AlbumList?.self)
            .subscribe(onNext: { (albums) in
                albumList.accept(albums ?? [])
            }, onError: { (error) in
                print("callApiForAlbumList: \(error)")
                isLoading.accept(false)
            })
    }
    
}

//
//  NetworkManager.swift
//  AlbumList
//
//  Created by Bowie Tso on 30/3/2023.
//

import Foundation
import Moya
import RxCocoa
import RxSwift

struct NetworkManager {
    static let apiProvider: MoyaProvider<API> = {
        let manager = DefaultAlamofireManager.sharedManager
        let provider = MoyaProvider<API>(session: manager)
        return provider
    }()
    
    static let REQUEST_TIMEOUT = 20
    static let CALL_BACK_TIMEOUT = 20
}

extension NetworkManager {
    static func requestRestfulAPI<T: Codable>(target: API, retryTimes: Int = 1, type: T.Type) -> Observable<String>{
        return NetworkManager.requestBy(target: target, retryTimes: retryTimes, type: type)
    }
    
    fileprivate static func requestBy<T: Codable>(target: API, retryTimes: Int = 1, type: T.Type) -> Observable<String> {
        let request = NetworkManager.apiProvider.rx.request(target,
                                                                        callbackQueue: DispatchQueue.main)
            .asObservable()
            .mapString()
            .autoHandlingGeneralAPIError(retryTimes, modelType: type)
        return request
    }
}

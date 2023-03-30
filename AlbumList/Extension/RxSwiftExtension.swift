//
//  RxSwiftExtension.swift
//  AlbumList
//
//  Created by Bowie Tso on 30/3/2023.
//

import Foundation
import Moya
import RxCocoa
import RxSwift

extension ObservableType where Element == String {
    
    func mapAPIObject<T: Codable>(element: T.Type, retry: Bool = true) -> Observable<T> {
        return self.flatMap { jsonStr -> Observable<T> in
            guard let data = jsonStr.data(using: .utf8) else { return .error(NSError())}
            do {
                let jsonDecoder = JSONDecoder()
                jsonDecoder.dateDecodingStrategy = .iso8601
                let responseModel = try jsonDecoder.decode(ResponseModel<T>.self, from: data)
                if responseModel.errorMessage != nil  {
                    let error = NSError(domain: "", code: 20000, userInfo: nil)
                    return .error(error)
                }
                let newModel =  responseModel.results ?? nil
                return .just(newModel!)
            } catch {
                print("MapObject: \(element)")
                print("Error: \(error)")
                return .error(error)
            }
        }
    }
    
    func autoHandlingGeneralAPIError<T:Codable>(_ retryTimes: Int, modelType: T.Type) -> Observable<String> {
        return self.flatMap { jsonString -> Observable<String> in
            if let responseModel  = (try? JSONDecoder().decode(ResponseModel<T>.self, from: jsonString.data(using: .utf8) ?? Data())) {
                print("can map to api response model")
                if responseModel.errorMessage != nil {
                    let error = NSError(domain: "API General Error",
                                        code: 20000,    //dummy error code
                                        userInfo: nil)
        
                    return Observable.deferred({
                        print("GeneralAPIError :", error)
                        throw error
                    }).catch({ error -> Observable<String> in
                        return Observable.error(error)
                    })
                    
                }
            } else {
                print("this is API error")
                print(jsonString)
                return .just(jsonString)
            }
            
            return .just(jsonString)
        }.catch({ (error) -> Observable<String> in
            
            if let responseError = error as? MoyaError,
               let statusCode = responseError.response?.statusCode {
                
                switch statusCode {
                case 200..<300:
                    print("HTTP Status code success")
                case 400..<500:
                    print("HTTP Status code client error")
                case 500..<600:
                    print("HTTP Status code server error")
                default:
                    print("HTTP undefined error")
                }
            }
            return Observable.error(error)
        })
        .retry { (rxError: Observable<Error>) -> Observable<Int> in
            return rxError.enumerated().flatMap { (index, error) -> Observable<Int> in
                guard index < retryTimes else {
                    return Observable.error(error)
                }
                return Observable<Int>.timer(.milliseconds(300), scheduler: MainScheduler.asyncInstance)
            }
        }
    }
}

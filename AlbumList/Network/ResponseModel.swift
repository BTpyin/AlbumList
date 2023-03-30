//
//  ResponseModel.swift
//  AlbumList
//
//  Created by Bowie Tso on 30/3/2023.
//

import Foundation
struct ResponseModel<T: Codable> : Codable {
    let errorMessage: String?
    let resultCount: Int?
    let results: T?
    
    enum CodingKeys: String, CodingKey {
        case errorMessage = "errorMessage"
        case results = "results"
        case resultCount = "resultCount"
    }

}

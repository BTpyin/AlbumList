//
//  API.swift
//  AlbumList
//
//  Created by Bowie Tso on 30/3/2023.
//

import Foundation
import Moya

enum API {
    case search(keyword: String)
}

extension API: TargetType {
    var baseURL: URL {
        return BASE_URL
    }
    
    var path: String {
        switch self {
        case .search:
            return "/search"
        }
    }
    
    var method: Moya.Method {
        .get
    }
    
    var task: Moya.Task {
        switch self {
            case .search(let keyword):
                return .requestParameters(parameters: ["term" : keyword,
                                                       "lang" : (isLanguageEN ? "en_us" : "zh_hk"),
                                                       "entity" : "album"],
                                          encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}

//
//  EncodeExtension.swift
//  AlbumList
//
//  Created by Bowie Tso on 30/3/2023.
//

import Foundation
extension String {
    
    func removeSpaceForKeywordSearch() -> String {
        return self.replacingOccurrences(of: " ", with: "+")
    }
    
    func urlEncode() -> String? {
        return self.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)
    }
    
    func encodeUrl() -> String? {
        return self.addingPercentEncoding( withAllowedCharacters: .urlQueryAllowed)?.replacingOccurrences(of: "&", with: "%26")
    }
    
    func decodeUrl() -> String? {
        return self.removingPercentEncoding
    }
    
}

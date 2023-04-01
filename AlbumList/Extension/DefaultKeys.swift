//
//  DefaultKeys.swift
//  AlbumList
//
//  Created by Bowie Tso on 1/4/2023.
//

import Foundation
import SwiftyUserDefaults

extension DefaultsKeys {
    
    var favourite_albums: DefaultsKey<AlbumList?> { .init("favourite_albums")}

}

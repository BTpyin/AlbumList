//
//  UITabBarItemExtension.swift
//  AlbumList
//
//  Created by Bowie Tso on 3/4/2023.
//

import UIKit
extension UITabBarItem {
    @IBInspectable var localizedKey: String {
        set {
            title = newValue.string()
        }
        
        get {
            return title ?? ""
        }
    }
}

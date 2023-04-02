//
//  UIButtonExtension.swift
//  AlbumList
//
//  Created by Bowie Tso on 2/4/2023.
//

import UIKit
extension UIButton {
    @IBInspectable var localizedKey: String {
        set {
            titleForNormal = newValue.string()
        }
        
        get {
            return titleForNormal ?? ""
        }
    }
}

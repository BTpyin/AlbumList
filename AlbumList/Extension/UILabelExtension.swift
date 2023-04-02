//
//  UILabelExtension.swift
//  AlbumList
//
//  Created by Bowie Tso on 2/4/2023.
//

import UIKit
extension UILabel {
    @IBInspectable var localizedKey: String {
        set {
            text = newValue.string()
        }
        get {
            return text ?? ""
        }
    }
}

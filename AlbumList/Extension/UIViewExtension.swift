//
//  UIViewExtension.swift
//  AlbumList
//
//  Created by Bowie Tso on 31/3/2023.
//

import UIKit
extension UIView {
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize = .zero, radius: CGFloat = 1) {
        layer.masksToBounds = false
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offSet
        layer.shadowRadius = radius
    }
    
}

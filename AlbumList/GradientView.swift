//
//  GradientView.swift
//  AlbumList
//
//  Created by Bowie Tso on 3/4/2023.
//

import UIKit

class GradientView: UIView {
    
    var gradientLayer = CAGradientLayer()

    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = self.bounds
    }
    
    func applyGradient(colors: [CGColor]) {
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.25, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
        self.layer.sublayers?.removeAll(where: {$0 is CAGradientLayer})
        self.layer.insertSublayer(self.gradientLayer, at: 0)
        self.translatesAutoresizingMaskIntoConstraints = false
        layoutSubviews()
    }

}

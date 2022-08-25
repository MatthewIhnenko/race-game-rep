//
//  File.swift
//  RaceGame 1.0
//
//  Created by Matthew on 11.05.22.
//

import Foundation
import UIKit


extension UIButton {
    func shadow(color: UIColor = UIColor(named: "CarRedColor") ?? .red,
                    offset: CGSize = CGSize(width: 5, height: 5),
                    opacity: Float = 0.7,
                    radius: CGFloat = 5) {
        layer.shadowColor = color.cgColor
        layer.shadowOpacity = opacity
        layer.shadowOffset = offset
        layer.shadowRadius = radius
    }
}


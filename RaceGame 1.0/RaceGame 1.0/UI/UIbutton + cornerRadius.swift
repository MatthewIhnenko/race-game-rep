//
//  UIview + cornerRadius.swift
//  RaceGame 1.0
//
//  Created by Matthew on 11.05.22.
//

import Foundation
import UIKit

extension UIButton {
    var cornerRadius: CGFloat {
        set {
            self.layer.cornerRadius = newValue
           //self.clipsToBounds = true
        }
        
        get {
            return self.layer.cornerRadius
        }
    }
}


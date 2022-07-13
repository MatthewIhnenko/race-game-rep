//
//  UIfonts.swift
//  RaceGame 1.0
//
//  Created by Matthew on 16.05.22.
//

import UIKit

extension UIFont {
    static func buttershine(with size: CGFloat) -> UIFont {
        let font = UIFont(name: "AnotherDangerDemo", size: size)
        return font ?? .systemFont(ofSize: size)

}
}

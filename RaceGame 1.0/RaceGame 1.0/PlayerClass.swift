//
//  PlayerClass.swift
//  RaceGame 1.0
//
//  Created by Matthew on 5.06.22.
//

import Foundation

class Player: Codable {
    
    var name: String
    var result: Int
    var date: String
    
    init(name: String, result: Int, date: String) {
    self.name = name
    self.result = result
    self.date = date
    }
}



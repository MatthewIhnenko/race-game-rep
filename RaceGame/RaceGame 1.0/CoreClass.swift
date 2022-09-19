//
//  CoreClass.swift
//  
//
//  Created by Matthew on 7.09.22.
//

import Foundation


class Core {
    
    static let shared = Core()
    
    func isNewUser() -> Bool{
        return !UserDefaults.standard.bool(forKey: "isNewUser")
    }
    
    func notNewUser(){
        UserDefaults.standard.set(true, forKey: "isNewUser")
    }
}

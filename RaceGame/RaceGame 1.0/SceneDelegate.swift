//
//  SceneDelegate.swift
//  RaceGame 1.0
//
//  Created by Matthew on 15.04.22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let storyboard = UIStoryboard(name: "StartViewController", bundle: nil)
        
        let viewcontroller = storyboard.instantiateViewController(identifier: "StartViewController")
        
        let window = UIWindow(windowScene: windowScene)
        window.rootViewController = viewcontroller
        window.makeKeyAndVisible()
        self.window = window

}

}

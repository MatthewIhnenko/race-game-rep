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

        
//        let firstLaunch = UserDefaults.standard.bool(forKey: "firstLaunch")
//        UserDefaults.standard.set(true, forKey: "firstLaunch")
//        
//        if(UserDefaults.standard.bool(forKey: "firstLaunch") == false){
//            UserDefaults.standard.set(true, forKey: "firstLaunch")
//            let storyboard = UIStoryboard(name: "OnBoardViewController", bundle: nil)
//            let viewController = storyboard.instantiateViewController(withIdentifier: "OnBoardViewController")
//            self.window?.rootViewController = viewController
//            self.window?.makeKeyAndVisible()
//        }else{
//           //Here you can show storyboard that you have to launch after first launch
//        }
//
        
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//
//        let storyboard = UIStoryboard(name: "StartViewController", bundle: nil)
//
//        let viewcontroller = storyboard.instantiateViewController(identifier: "StartViewController")
//
//        let window = UIWindow(windowScene: windowScene)
//        window.rootViewController = viewcontroller
//        window.makeKeyAndVisible()
//        self.window = window
        
//        guard let windowScene = (scene as? UIWindowScene) else { return }
//        
//        let storyboard = UIStoryboard(name: "OnBoardViewController", bundle: nil)
//        
//        let viewcontroller = storyboard.instantiateViewController(identifier: "OnBoardViewController")
//        
//        let window = UIWindow(windowScene: windowScene)
//        window.rootViewController = viewcontroller
//        window.makeKeyAndVisible()
//        self.window = window
        
        
        if Core.shared.isNewUser(){
            Core.shared.notNewUser()
            
            print("new user")
            
            guard let windowScene = (scene as? UIWindowScene) else { return }
            
            let storyboard = UIStoryboard(name: "OnBoardViewController", bundle: nil)
            
            let viewcontroller = storyboard.instantiateViewController(identifier: "OnBoardViewController")
            
            let window = UIWindow(windowScene: windowScene)
            window.rootViewController = viewcontroller
            window.makeKeyAndVisible()
            self.window = window
        }
            
        else{
        
                    guard let windowScene = (scene as? UIWindowScene) else { return }
            
                    let storyboard = UIStoryboard(name: "StartViewController", bundle: nil)
            
                    let viewcontroller = storyboard.instantiateViewController(identifier: "StartViewController")
            
            
                    let window = UIWindow(windowScene: windowScene)
                    window.rootViewController = viewcontroller
                    window.makeKeyAndVisible()
                    self.window = window

}

}
}

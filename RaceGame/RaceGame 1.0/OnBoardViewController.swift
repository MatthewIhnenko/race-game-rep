//
//  OnBoardViewController.swift
//  RaceGame 1.0
//
//  Created by Matthew on 7.09.22.
//

import UIKit

class OnBoardViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        
        
    }
//    override func viewWillAppear(_ animated: Bool) {
//            
//            if Core.shared.isNewUser(){
//                Core.shared.notNewUser()
//                
//                print("new user")
//            }
//                
//            else{
//                print("existing user")
//                
//                let viewcontroller = UIStoryboard(name: "StartViewController", bundle: nil).instantiateViewController(withIdentifier: "StartViewController")
//                
//                if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
//                    let sceneDelegate = windowScene.delegate as? SceneDelegate,
//                    let window = sceneDelegate.window{
//                    
//                    window.rootViewController = viewcontroller
//                    
//                    UIView.transition(with: window,
//                                      duration: 0.25,
//                                      options: .transitionCrossDissolve,
//                                      animations: nil,
//                                      completion: nil)
//                }
//            }
//            
//        }
    
    @IBAction func getStartedButtonPressed(_ sender: UIButton) {
        
        let startViewController = StartViewController.instantiate()
        startViewController.modalPresentationStyle = .overCurrentContext
        present(startViewController, animated: true)
        
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

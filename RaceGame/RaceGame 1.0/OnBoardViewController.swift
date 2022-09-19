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
    
    @IBAction func getStartedButtonPressed(_ sender: UIButton) {
        
        let startViewController = StartViewController.instantiate()
        startViewController.modalPresentationStyle = .overCurrentContext
        present(startViewController, animated: true)
        
        
    }
    
    


}

//
//  ViewController.swift
//  RaceGame 1.0
//
//  Created by Matthew on 15.04.22.
//

import UIKit

class StartViewController: UIViewController {
    
    // Лейбл названия игры
    @IBOutlet weak var gameNameLabel: UILabel!
    
    @IBOutlet weak var gameButton: UIButton!
    @IBOutlet weak var resultsButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    @IBOutlet weak var gameOverLabel: UILabel!
    
    var a: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //addNotification()
        
        
        // Лейбл названия игры настройки
        gameNameLabelSettings()
        gameNameLabel.font = UIFont.buttershine(with: 60)
        
        gameOverLabel.font = UIFont.buttershine(with: 40)
        
        //Кнопки
//        gameButton.setTitle("GAME", for: .normal)
////??? Не работает шрифт
//        gameButton.titleLabel?.font = UIFont.buttershine(with: 25)
//        gameButton.cornerRadius = 15
//        gameButton.backgroundColor = .systemTeal
        
        gameButton.setTitle("Game", for: .normal)
        gameButton.cornerRadius = 15
        gameButton.shadow()
        gameButton.backgroundColor = .systemTeal
        
//        gameButton.layer.shadowColor = UIColor.red.cgColor
//        gameButton.layer.shadowOffset = CGSize(width: 5, height: 5)
//        gameButton.layer.shadowRadius = 5
//        gameButton.layer.shadowOpacity = 0.7
        
        resultsButton.setTitle("Results", for: .normal)
        //resultsButton.titleLabel?.font = .buttershine(with: 25)
        resultsButton.cornerRadius = 15
        resultsButton.shadow()
        resultsButton.backgroundColor = .systemTeal
        
        settingsButton.setTitle("Settings", for: .normal)
        settingsButton.cornerRadius = 15
        settingsButton.backgroundColor = .systemTeal
        settingsButton.shadow()
        
        gameOverLabel.text = ""
        
        
    }
    

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        gameButton.titleLabel?.font = UIFont.buttershine(with: 25)
        resultsButton.titleLabel?.font = .buttershine(with: 25)
        settingsButton.titleLabel?.font = .buttershine(with: 25)
        
        
    }
    
    func gameNameLabelSettings() {
       let text = "CHICKENGEDDON"
        let attrText = NSMutableAttributedString(string: text)
        attrText.addAttribute(.foregroundColor, value: UIColor.red, range: NSRange(location: 0, length: 7))
        attrText.addAttribute(.foregroundColor, value: UIColor.black, range: NSRange(location: 7, length: 6))
        gameNameLabel.attributedText = attrText
        
        
    }
    
    
    
    

    @IBAction func gameButtonPressed(_ sender: UIButton) {
        //let storyboard = UIStoryboard(name: "GameViewController", bundle: nil)
        //let viewController = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        
        
        addNotification()
        let gameViewController = GameViewController.instantiate()
        
        present(gameViewController, animated: true)
        
}
    
    
    @IBAction func resultsButtonPressed(_ sender: UIButton) {
        
        let storyboard = UIStoryboard(name: "ResultsViewController", bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "ResultsViewController") as! ResultsViewController
        
        present(viewController, animated: true)
}
    
    
    @IBAction func settingsButtonPressed(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "SettingsViewController", bundle: nil)
        
        let viewController = storyboard.instantiateViewController(withIdentifier: "SettingsViewController") as! SettingsViewController
        
        present(viewController, animated: true)
}
  

    
    func addNotification() {
        
        let playerName = UserDefaults.standard.string(forKey: "PlayerName")!
        
        
        let content = UNMutableNotificationContent()
        content.title = "Hi, \(playerName)"
        content.subtitle = "It's time to have a ride"
        content.body = "Crazy chickens are waiting for you!"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
        
        let id = "last"
        let notificationRequest = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        
        notificationCenter.add(notificationRequest) { error in
            print("Notification added=)")
            guard let error = error else {
                return
            }
            print(error.localizedDescription)
            
        }
    }
    
    
    
    
    
}
    
    

    
    




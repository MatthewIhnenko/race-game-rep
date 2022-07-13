//
//  GameViewController.swift
//  RaceGame 1.0
//
//  Created by Matthew on 15.04.22.
//

import UIKit

class GameViewController: UIViewController {

    @IBOutlet weak var blackView: UIView!
    @IBOutlet weak var grayView: UIView!
    @IBOutlet weak var leftGrassView: UIView!
    @IBOutlet weak var rightGrassView: UIView!
    @IBOutlet weak var carImageGameView: UIImageView!
        
    @IBOutlet weak var scoreLabel: UILabel!
    
    private var score: Int = 0
    
    var playersResult: [Player] = []
    
    let decoder = JSONDecoder() // Позволяет превратить данные в объект
    let encoder = JSONEncoder() // Позволяет превратить объект в данные
    
    var gameOverText: String = "Game Over =("
    
    var gameModeNormal: Bool = true
    
    var gameStop: Bool = false
    
    var timerDate = Timer()
    
    //let date: String = "\(Date())"
    let date = Date()
    var formattedDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd-yyyy HH:mm"
        formatter.timeZone = .current
        return formatter
    }()
    

    
    var timer = Timer()
    var timerChickien = Timer()
    var timerChickien2 = Timer()
    
    //var playerNameGame = String
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
     // Режим сложности игры
        gameModeNormal = UserDefaults.standard.bool(forKey: "GameMode")
        
    // Вьюшка машинки
        carImageGameView.center.x = grayView.center.x
        carImageGameView.center.y = grayView.frame.maxY - carImageGameView.frame.height
        
    // Цвет машинки
        setupCarColor()
        
 
   //    crashChicken()
        
    }
    
//    func cancelTimer() {
//      timer.invalidate()
//    }
    
    func setupCarColor() {
        if UserDefaults.standard.bool(forKey: "red") == true {
            carImageGameView.image = UIImage(named: "car_new-removebg-preview")
        }
        if UserDefaults.standard.bool(forKey: "pink") == true {
            carImageGameView.image = UIImage(named: "car_pink")
        }
        if UserDefaults.standard.bool(forKey: "blue") == true {
            carImageGameView.image = UIImage(named: "car_blue")
        }
        if UserDefaults.standard.bool(forKey: "green") == true {
            carImageGameView.image = UIImage(named: "car_green")
        }
        
    }
    
    func setupAppearance() {
        
        //carImageGameView.image = UIImage(named: userDefaults?.string(forKey: "CarImageSave") ?? "car_blue.png")
        carImageGameView.image = UIImage(named: "car_pink")
        carImageGameView.image = UIImage(named: UserDefaults.standard.string(forKey: "CarImageSave") ?? "MISTAKE")
         
        print(UserDefaults.standard.string(forKey: "CarImageSave") ?? "lol?")
        print(carImageGameView.image ?? "MISTAKE1 =(")
        
    }
    
    
    
    // ***!Кнопка старта игры!***
    
    @IBAction func startButtonPressed(_ sender: UIButton) {
    //Делаем кнопку старта невидимой
        sender.isHidden = true
        
         
    //Таймер очков (секунды)
        scoreTimer()
    //Таймер деревьев на обочине
        timerRightTree()
    //Таймер знака 90 на обочине
        timerZnak()
    //Таймер запуска разделительной полосы
        timerRoadline1()
   // Таймеры запуска куриц
        chickenMode()
        
       //dateTimer()
        
        
   // Сохранялка очко ???
        //saveScore()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       // alertUserName()
    }
    
    func chickenMode() {
        if gameModeNormal == true {
            timerRightChickenRunning()
        } else {timerLeftChickenRunning()
        }
    }

//    func crashChicken() {
//        if carImageView.frame.intersects(chickenImageView.frame) {
//            print("ВЫ СБИЛИ КУРИЦУ, СУДАРЬ!")
//            print("------------------------")
//        }
//    }
    
   private func stopGame() {
       
       if !self.gameStop {
           
           self.gameStop = true

           var d: String = formattedDate.string(from: date)
           
           UserDefaults.standard.set(d, forKey: "TimePlay")
           print("Время рекорда - \(UserDefaults.standard.string(forKey: "TimePlay"))")

           
           
           
               self.timer.invalidate()
               
               UserDefaults.standard.set(self.score, forKey: "scores")
           print("Набранные очки - \(UserDefaults.standard.integer(forKey: "scores"))")
           
           //self.timerDate.invalidate()
           
           
               
           
          // print("TIMER STOPGAME",self.gameStop)
           saveScore()
           
           let startViewController = StartViewController.instantiate()
           startViewController.gameOverLabel?.text = gameOverText
           
           dismiss(animated: true)
       }
        //Наверное так неправильно!!!
        
//        let startViewController = StartViewController.instantiate()
//        present(startViewController, animated: true)
//        startViewController.gameOverLabel?.text = gameOverText

       
        //gameStop = false
        
    }
    
    
    
    func crashGrass() {
        if carImageGameView.frame.intersects(leftGrassView.frame) {
            
            
            //self.gameStop = true
            
//            if gameStop == true {
//         stopGame()
//            }
            
        stopGame()
            print("Выезд за трассу слева")
            
            
        } else if carImageGameView.frame.intersects(rightGrassView.frame) {
            
//            self.gameStop = true
//            if gameStop == true {
//         stopGame()
//            }
            
            stopGame()
            
            print("Выезд за трассу справа")
            
        }else {
            print("OK")
        }
    }

    @IBAction func leftButtonPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear) {
            self.carImageGameView.center.x -= 20
            self.carImageGameView.transform = CGAffineTransform(rotationAngle: 25)
            self.crashGrass()
        } completion: { _ in
           self.carImageGameView.transform = CGAffineTransform(rotationAngle: 0)
            print("Рулим налево ")
        }
    }
    
    @IBAction func rightButtonPressed(_ sender: UIButton) {
        UIView.animate(withDuration: 0.4, delay: 0, options: .curveLinear) {
            self.carImageGameView.center.x += 20
            self.carImageGameView.transform = CGAffineTransform(rotationAngle: -25)
            self.crashGrass()
        } completion: { _ in
           self.carImageGameView.transform = CGAffineTransform(rotationAngle: 0)
            print("Рулим направо ")
    }
}
    func timerZnak() {
         
        Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            let znak90View = UIImageView()
            znak90View.frame.size = CGSize(width: 50, height: 50)
            znak90View.image = UIImage(named: "znak_90-removebg-preview.png")
            znak90View.center = CGPoint(x:self.leftGrassView.frame.width / 2, y: 0)
            self.leftGrassView.addSubview(znak90View)
            UIView.animate(withDuration: 2, delay: 0, options: .curveLinear) {
                znak90View.frame.origin.y = self.leftGrassView.frame.maxY - (znak90View.frame.height * 2)
            } completion: { _ in
                 
                znak90View.removeFromSuperview()
                
            }
        }
    }

     
    func timerRoadline1() {
    
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            let roadLine8 = UIView()
            roadLine8.frame.size = CGSize(width: 10, height: 50)
            roadLine8.center = CGPoint(x:self.blackView.frame.width / 2, y: -50)
            roadLine8.backgroundColor = .white

            self.blackView.addSubview(roadLine8)
            UIView.animate(withDuration: 2, delay: 0, options: .curveLinear) {
                roadLine8.frame.origin.y = self.grayView.frame.maxY
                roadLine8.frame.origin.y = self.grayView.frame.maxY
            } completion: { _ in
                roadLine8.removeFromSuperview()
            }
        }
    }
    
    
    func timerRightTree() {
        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
            let treeView = UIImageView()
            treeView.frame.size = CGSize(width: self.rightGrassView.frame.width, height: 50)
            treeView.image = UIImage(named: "tree_2d")
            treeView.center = CGPoint(x:self.rightGrassView.frame.width / 2, y: 0)
//            treeView.center.x = self.rightGrassView.center.x
//            treeView.center.y = self.rightGrassView.frame.minY + 50
            self.rightGrassView.addSubview(treeView)
            UIView.animate(withDuration: 2, delay: 0, options: .curveLinear) {
                treeView.frame.origin.y = self.rightGrassView.frame.maxY - (treeView.frame.height * 2)
            } completion: { _ in
                treeView.removeFromSuperview()
            }
            
        }
    }
    
    
    
    
    
    
    func timerRightChickenRunning() {
         
        timerChickien = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            let rightChicken = UIImageView()
            rightChicken.frame.size = CGSize(width: 70, height: 70)
            rightChicken.image = UIImage(named: "chicken.png")
            
            rightChicken.center.x = self.grayView.center.x + rightChicken.frame.width
            //rightChicken.center.y = self.grayView.frame.minY - rightChicken.frame.height
            var way = self.grayView.center.x + rightChicken.frame.width
            let chickenLine = Bool.random()
            if chickenLine {
                 way = self.grayView.center.x - rightChicken.frame.width
            } else {
                 way = self.grayView.center.x + rightChicken.frame.width
            }
            rightChicken.center.x = way
            self.view.addSubview(rightChicken)
            rightChickenRunningSettings()
            func rightChickenRunningSettings() {
            UIView.animate(withDuration: 0.001, delay: 0, options: .curveLinear) {
                rightChicken.frame.origin.y += 5
            } completion: { _ in
                
                if rightChicken.frame.intersects(self.carImageGameView.frame) {
                    self.timerChickien.invalidate()
                    self.stopGame()
                    
//                    self.gameStop = true
//                    if self.gameStop == true {
//                        self.timerChickien.invalidate()
//                        self.stopGame()
//                    }
                    print("ВЫ СБИЛИ КУРИЦУ, СУДАРЬ!")
                    print("------------------------")
                    
                } else if rightChicken.frame.origin.y < self.grayView.frame.maxY {
                    rightChickenRunningSettings()
                    //print(rightChicken.center.y)
                }
                if rightChicken.frame.origin.y > self.grayView.frame.maxY {
                    rightChicken.removeFromSuperview()
                }
   }
  }
             
 }
}
    
    func timerLeftChickenRunning() {
         
        timerChickien2 =  Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { _ in
            let leftChicken = UIImageView()
            leftChicken.frame.size = CGSize(width: 70, height: 70)
            leftChicken.image = UIImage(named: "chicken_crazy")
            
//            var left = self.grayView.center.x - leftChicken.frame.width
//            var right = self.grayView.center.x + leftChicken.frame.width
            
            var way = self.grayView.center.x + leftChicken.frame.width
            let chickenLine = Bool.random()
            if chickenLine {
                 way = self.grayView.center.x - leftChicken.frame.width
            } else {
                 way = self.grayView.center.x + leftChicken.frame.width
            }
            
            leftChicken.center.x = way
            
            //leftChicken.center.y = self.grayView.frame.minY - leftChicken.frame.height
            
            self.view.addSubview(leftChicken)
            
            leftChickenRunningSettings()
            
            func leftChickenRunningSettings() {
            UIView.animate(withDuration: 0.01, delay: 0, options: .curveLinear) {
                leftChicken.frame.origin.y += 5
            } completion: { _ in
                
                if leftChicken.frame.intersects(self.carImageGameView.frame) {
                    
                    self.timerChickien2.invalidate()
                    self.stopGame()
                    
//                    self.gameStop = true
//
//                    if self.gameStop == true {
//                        self.timerChickien2.invalidate()
//                        self.stopGame()
//                    }
                    print("ВЫ СБИЛИ   КУРИЦУ, СУДАРЬ!")
                    print("------------------------")
                    
                } else if leftChicken.frame.origin.y < self.grayView.frame.maxY {
                    leftChickenRunningSettings()
                    //print(leftChicken.center.y)
                }
                
                if leftChicken.center.y > self.grayView.frame.maxY {
                    leftChicken.removeFromSuperview()
                }
   }
  
            }
             
 }
}
    
    func dateTimer() {
            timerDate = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
                
                 
                    
                    

                    //self.saveScore()

                   // print("Зафиксированное время", UserDefaults.standard.string(forKey: "TimePlay")!)
                
            })
        }
    
    func scoreTimer() {
       
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { _ in
            self.score += 1
            self.scoreLabel.text = "\(self.score)"
            //print(self.score)
            //print("TIMER",self.gameStop)

            
            }
        
        }
    
//    func alertUserName() {
//
//        let alertUserName = UIAlertController(title: "Hello, my friend!", message: "Let's get acquainted", preferredStyle: .alert)
//
//        alertUserName.addTextField(configurationHandler: { textField in
//            textField.placeholder = "Enter your name here"
//            //textField.isSecureTextEntry = true
//            textField.clearButtonMode = .always
//        })
//
//        let ok = UIAlertAction(title: "Enter!", style: .default, handler: { (action) -> Void in
//            print("----------------------")
//            print("Username is entered")
//            let password = alertUserName.textFields?.first?.text ?? ""
//            print("Username is: \(password)")
//            print("----------------------")
//        })
//
//        alertUserName.addAction(ok)
//
//        present(alertUserName, animated: true)
//    }
    
    func saveScore() {
        
        if let data = UserDefaults.standard.value(forKey: "info") as? Data {
            do {
                playersResult = try decoder.decode([Player].self, from: data)
                 
            } catch {
                print(error.localizedDescription)
            }
        }
        
        if let result = UserDefaults.standard.value(forKey: "scores") as? Int {
            
            print("Сохранены очки \(result)")
            
            let playerName: String = UserDefaults.standard.string(forKey: "PlayerName") ?? "error name"
            
            let date: String = UserDefaults.standard.string(forKey: "TimePlay") ?? "error_date"
            
            let player = Player(name: playerName, result: result, date: date)
            
            //print("GAMER",player)
            playersResult.append(player)
            playersResult.sort(by: {$0.result > $1.result})
            
            if playersResult.count == 12 {
                playersResult.removeLast()
            }
        }
        
        do {
            let data = try encoder.encode(playersResult)
            UserDefaults.standard.set(data, forKey: "info")
            print("Выход \(data)")
            
        } catch {
            print(error.localizedDescription)
        }
        
//        print("Каунт массива результатов",playersResult.count)
//        print("=======")
//        print("Дата1: \(playersResult[0].date)")
//        print("Результат: \(playersResult[0].result)")
//
//        print("Дата2: \(playersResult[1].date)")
//        print("Результат2: \(playersResult[1].result)")
//
//        print("Дата3: \(playersResult[2].date)")
//        print("Результат3: \(playersResult[2].result)")
//        print("=======")
        
    }
    
    
    
  
    
    
    
    
        }

        
    
    
    



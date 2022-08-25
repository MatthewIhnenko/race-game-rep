//
//  SettingsViewController.swift
//  RaceGame 1.0
//
//  Created by Matthew on 15.04.22.
//

import UIKit

class SettingsViewController: UIViewController {

    
    @IBOutlet weak var swipeCarLabel: UILabel!
    
    @IBOutlet weak var swipeDifficultyLabel: UILabel!
    
    
    
    
    // Сущность объекта должна реализовывать протокол Codable
    let decoder = JSONDecoder() // Позволяет превратить данные в объект
    let encoder = JSONEncoder() // Позволяет превратить объект в данные
    
    
    
    //Car
    @IBOutlet weak var sliderImageView1: UIImageView!
    
    @IBOutlet weak var sliderImageView2: UIImageView!
    
    @IBOutlet weak var carChoserView: UIView!
    
    @IBOutlet weak var carTypeLabel: UILabel!
    
    
    
    
    
    //Chicken
    @IBOutlet weak var sliderChickenImageView1: UIImageView!
    
    @IBOutlet weak var sliderChickenImageView2: UIImageView!
    
    @IBOutlet weak var difficultyChoserView: UIView!
    
    @IBOutlet weak var chickenTypeLabel: UILabel!
    
    
    @IBOutlet weak var enterYourNameTextField: UITextField!
    
    
    @IBOutlet weak var playerNameLabel: UILabel!
    
    
    var playerName: String?
    
    
    
    
    // Управления картинками машин
    var currenCar = 0
    var rightCar:Int = -1
    var leftCar = -1
    // Массив картинок и массив вьюшек
    //var carsImages:[UIImage] = []
    var carsImages:[UIImage] = []
    var sliderArray:[UIImageView] = []
    //Управление индексами массива вьюшек
    var currentIndex: Int = 0
    var nextIndex: Int = -1
    
    
    // Управления картинками chicken
    var currenChicken  = 0
    var rightChicken:Int = -1
    var leftChicken = -1
    // Массив картинок и массив вьюшек
    var chickenImages:[UIImage] = []
    var sliderArrayChicken:[UIImageView] = []
    //Управление индексами массива вьюшек
    var currentIndexChicken: Int = 0
    var nextIndexChicken: Int = -1
    
    
    
    var red = false
    var blue = false
    var pink = false
    var green = false
     
    
    enum CarImages: String {
        case blueLagoon, pinkPanter, redFury, greenMan
        
        var imageCar: UIImage? {
            switch self {
            case .blueLagoon:
                return UIImage(named: "car_blue")
            case .pinkPanter:
                return UIImage(named: "car_pink")
            case .redFury:
                return UIImage(named: "car_new-removebg-preview")
            case .greenMan:
                return UIImage(named: "car_green")
             
            }
        }
    }
    
    
//    override func viewWillAppear(_ animated: Bool) {
//        sliderImageView1.frame.origin = CGPoint(x: (carChoserView.frame.width / 2) - (sliderImageView1.frame.width / 2), y: swipeCarLabel.frame.height + 1)
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        swipeCarLabel.font = UIFont.buttershine(with: 30)
        carTypeLabel.font = UIFont.buttershine(with: 25)
        swipeDifficultyLabel.font = UIFont.buttershine(with: 30)
        chickenTypeLabel.font = UIFont.buttershine(with: 30)
        
        print("CAR LABEL",swipeCarLabel.frame.height + 1)
        sliderImageView1.frame.origin = CGPoint(x: (carChoserView.frame.width / 2) - (sliderImageView1.frame.width / 2), y: swipeCarLabel.frame.height + 21)
        
        
        
        
        enterYourNameTextField.delegate = self
        
        chickenTypeLabel.text = "Normal"
        
        playerNameLabel.text = "Hi, \(UserDefaults.standard.string(forKey: "PlayerName") ?? "No name driver!")!"
        
        gestureCar()
        gestureCar2()
        
        gestureChicken()
        gestureChicken2()
        
//        let carPink: UIImage = (UIImage(named: "car_pink")!)
//        let carRed: UIImage = (UIImage(named: "car_new-removebg-preview")!)
//        let carGreen: UIImage = (UIImage(named: "car_green")!)
//        let carBlue: UIImage = (UIImage(named: "car_blue")!)
        
       //let carPink = CodableImage(image: (UIImage(named: "car_blue")!))
        
        
        
        carsImages.append(CarImages.pinkPanter.imageCar!)
        carsImages.append(CarImages.redFury.imageCar!)
        carsImages.append(CarImages.greenMan.imageCar!)
        carsImages.append(CarImages.blueLagoon.imageCar!)
         
        chickenImages.append(UIImage(named: "chicken")!)
        chickenImages.append(UIImage(named: "chicken_crazy")!)
        
        
        // Включение функции свайпа
        setupSwipeGestureRecognizer()
        
        setupSwipeGestureRecognizerChicken()
        
        
        self.sliderImageView1.image = carsImages[0]
        
        self.sliderChickenImageView1.image = chickenImages[0]
        
        sliderImageView1.isUserInteractionEnabled = true
        sliderImageView2.isUserInteractionEnabled = true
        carChoserView.isUserInteractionEnabled = true
       
        sliderChickenImageView1.isUserInteractionEnabled = true
        sliderChickenImageView2.isUserInteractionEnabled = true
        difficultyChoserView.isUserInteractionEnabled = true
        
        sliderArray.append(sliderImageView1)
        sliderArray.append(sliderImageView2)
        
        sliderArrayChicken.append(sliderChickenImageView1)
        sliderArrayChicken.append(sliderChickenImageView2)
        
    }
    
    private func setupSwipeGestureRecognizerChicken() {
          let rightSwipe = UISwipeGestureRecognizer()
          rightSwipe.addTarget(self, action: #selector(handleSwipeChicken))
          rightSwipe.direction = .right
        difficultyChoserView.addGestureRecognizer(rightSwipe)
          
          let leftSwipe = UISwipeGestureRecognizer()
          leftSwipe.addTarget(self, action: #selector(handleSwipeChicken))
          leftSwipe.direction = .left
        difficultyChoserView.addGestureRecognizer(leftSwipe)
      }
      //Логика свайпа
      @objc
      func handleSwipeChicken(_ sender: UISwipeGestureRecognizer) {
          switch sender.direction {
          case .right:
              
              
              if self.nextIndexChicken == -1 {
                  self.nextIndexChicken = self.sliderArrayChicken.count - 1
              }
              
              
              if self.leftChicken == -1 {
                  self.sliderArrayChicken[self.nextIndexChicken].image = self.chickenImages[self.chickenImages.count - 1]
                  print("NOW")
                  leftChicken = self.chickenImages.count - 1
                  rightChicken = 1
                  
              } else {
                  self.sliderArrayChicken[self.nextIndexChicken].image = self.chickenImages[self.leftChicken]}
              
              self.sliderArrayChicken[self.nextIndexChicken].frame.origin =  CGPoint(x: -480, y: swipeDifficultyLabel.frame.height + 1)
              
              print("Swipe right")
              
             
              
              UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) { [self] in
                  
                  //1я картинка
                  self.sliderArrayChicken[currentIndexChicken].frame.origin = CGPoint(x: 480, y: swipeDifficultyLabel.frame.height + 1)
                  //2я картинка
                  self.sliderArrayChicken[nextIndexChicken].frame.origin = CGPoint(x: (difficultyChoserView.frame.width / 2) - (self.sliderArrayChicken[nextIndexChicken].frame.width / 2), y: swipeDifficultyLabel.frame.height + 1)
                  
                  
              } completion: { [self] _ in
                  
                  
                  if self.currenChicken - 1 < 0 {
                      self.currenChicken = self.chickenImages.count - 1
                  } else {
                      self.currenChicken -= 1
                  }
                  
                  
                  if self.rightChicken - 1 < 0 {
                      self.rightChicken = self.chickenImages.count - 1
                  } else {
                      self.rightChicken -= 1
                  
                  }
                  
                  if self.leftChicken - 1 < 0 {
                      self.leftChicken = self.chickenImages.count - 1
                  } else {
                      self.leftChicken -= 1
                  
                  }
                  
                  if self.currentIndexChicken - 1 < 0 {
                      self.currentIndexChicken = self.sliderArrayChicken.count - 1
                  } else {
                      self.currentIndexChicken -= 1
                  }
                  
                  if self.nextIndexChicken - 1 < 0 {
                      self.nextIndexChicken = self.sliderArrayChicken.count - 1
                  } else {
                      self.nextIndexChicken -= 1
                  }
              }
          
          case .left:
              
              if self.nextIndexChicken == -1 {
                  self.nextIndexChicken = 1
              }
              
              if self.rightChicken == -1 {
                  self.sliderArrayChicken[self.nextIndexChicken].image = self.chickenImages[1]
                  self.rightChicken = 1
                  self.leftChicken = chickenImages.count - 1
                  
              } else {
                  self.sliderArrayChicken[self.nextIndexChicken].image = self.chickenImages[self.rightChicken]}
              
              self.sliderArrayChicken[self.nextIndexChicken].frame.origin =  CGPoint(x: 480, y: swipeDifficultyLabel.frame.height + 1)
              
              print("Swipe left")
              
              
              UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) { [self] in
                  self.sliderArrayChicken[currentIndexChicken].frame.origin = CGPoint(x: -480, y: 0)

                  self.sliderArrayChicken[nextIndexChicken].frame.origin = CGPoint(x: (difficultyChoserView.frame.width / 2) - (self.sliderArrayChicken[nextIndexChicken].frame.width / 2), y: swipeDifficultyLabel.frame.height + 1)
                  
                   
                  
              } completion: { _ in
                  
                  //self.sliderArray[self.currentIndex].frame.origin =  CGPoint(x: 400, y: 150)
                  
                  if self.currenChicken + 1 >= self.chickenImages.count {
                      self.currenChicken = 0
                  } else {
                      self.currenChicken += 1
                  }
                  
                  if self.rightChicken + 1 >= self.chickenImages.count {
                      self.rightChicken = 0
                  } else {
                      self.rightChicken += 1
                  }

                  if self.leftChicken + 1 >= self.chickenImages.count {
                      self.leftChicken = 0
                  } else {
                      self.leftChicken += 1
                  }
                  
                  if self.currentIndexChicken + 1 >= self.sliderArrayChicken.count {
                      self.currentIndexChicken = 0
                  } else {
                      self.currentIndexChicken += 1
                  }
                  
                  if self.nextIndexChicken + 1 >= self.sliderArrayChicken.count {
                      self.nextIndexChicken = 0
                  } else {
                      self.nextIndexChicken += 1
                  }
              }
              
          default:
              break
          }

        print("Левый кот \(leftChicken)")
        print("Правый кот \(rightChicken)")
         print("Текущий кот \(currenChicken)")
          print("------------")
          
          if currenChicken == 0 {
              chickenTypeLabel.text = "Insane"
          } else {
              chickenTypeLabel.text = "Normal"
          }
          
          
  }
    
    
   //CAR!!!!!CAR!!!!!CAR!!!!!CAR!!!!!CAR!!!!!CAR!!!!!CAR!!!!!CAR!!!!!CAR!!!!!
    
  private func setupSwipeGestureRecognizer() {
        let rightSwipe = UISwipeGestureRecognizer()
        rightSwipe.addTarget(self, action: #selector(handleSwipe))
        rightSwipe.direction = .right
        carChoserView.addGestureRecognizer(rightSwipe)
        
        let leftSwipe = UISwipeGestureRecognizer()
        leftSwipe.addTarget(self, action: #selector(handleSwipe))
        leftSwipe.direction = .left
        carChoserView.addGestureRecognizer(leftSwipe)
    }
    //Логика свайпа
    @objc
    func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        switch sender.direction {
        case .right:
            
            if self.nextIndex == -1 {
                self.nextIndex = self.sliderArray.count - 1
            }
            
            if self.leftCar == -1 {
                self.sliderArray[self.nextIndex].image = self.carsImages[self.carsImages.count - 1]
                 
                leftCar = self.carsImages.count - 1
                rightCar = 1
                
            } else {
                self.sliderArray[self.nextIndex].image = self.carsImages[self.leftCar]}
            
            self.sliderArray[self.nextIndex].frame.origin =  CGPoint(x: -480, y: swipeCarLabel.frame.height + 1)
            
            print("Swipe right")
            print("CAR LABEL",swipeCarLabel.frame.height + 1)
             
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) { [self] in
                
                //1я картинка
                self.sliderArray[currentIndex].frame.origin = CGPoint(x: 480, y: swipeCarLabel.frame.height + 1)
                
                
                rightSwapCarRecognition()
                //Настройка чере ЕНУМ
               // rightSwapCarSaving()
                //Настройка через БУЛ
                rightSwapCarSaving2()
                
                
                //2я картинка
                self.sliderArray[nextIndex].frame.origin = CGPoint(x: (carChoserView.frame.width / 2) - (self.sliderArray[nextIndex].frame.width / 2), y: swipeCarLabel.frame.height + 1)
                
                
            } completion: { [self] _ in

                 
                
                if self.currenCar - 1 < 0 {
                    self.currenCar = self.carsImages.count - 1
                } else {
                    self.currenCar -= 1
                }
                
                
                if self.rightCar - 1 < 0 {
                    self.rightCar = self.carsImages.count - 1
                } else {
                    self.rightCar -= 1
                
                }
                
                if self.leftCar - 1 < 0 {
                    self.leftCar = self.carsImages.count - 1
                } else {
                    self.leftCar -= 1
                
                }
                
                if self.currentIndex - 1 < 0 {
                    self.currentIndex = self.sliderArray.count - 1
                } else {
                    self.currentIndex -= 1
                }
                
                if self.nextIndex - 1 < 0 {
                    self.nextIndex = self.sliderArray.count - 1
                } else {
                    self.nextIndex -= 1
                }
            }
        
        case .left:
            
            if self.nextIndex == -1 {
                self.nextIndex = 1
            }
            
            if self.rightCar == -1 {
                self.sliderArray[self.nextIndex].image = self.carsImages[1]
                self.rightCar = 1
                self.leftCar = carsImages.count - 1
                
            } else {
                self.sliderArray[self.nextIndex].image = self.carsImages[self.rightCar]}
            
            self.sliderArray[self.nextIndex].frame.origin =  CGPoint(x: 480, y: swipeCarLabel.frame.height + 1)
            //self.sliderArray[self.nextIndex].center =  CGPoint(x: 480, y: swipeCarLabel.frame.height + 1)
            
            print("Swipe left")
            
            
            UIView.animate(withDuration: 0.5, delay: 0, options: .curveLinear) { [self] in
                self.sliderArray[currentIndex].frame.origin = CGPoint(x: -480, y: swipeCarLabel.frame.height + 1)
                
                //Отображение лейбла с названием
                leftSwapCarRecognition()
                
                //Настройка через ЕНУМ
                //leftSwapCarSaving()
                
                //Настройка через БУЛ
                leftSwapCarSaving2()

                self.sliderArray[nextIndex].frame.origin = CGPoint(x: (carChoserView.frame.width / 2) - (self.sliderArray[nextIndex].frame.width / 2), y: swipeCarLabel.frame.height + 1)
                
                 
                
            } completion: { _ in
                
                //self.sliderArray[self.currentIndex].frame.origin =  CGPoint(x: 400, y: 150)
                
                if self.currenCar + 1 >= self.carsImages.count {
                    self.currenCar = 0
                } else {
                    self.currenCar += 1
                }
                
                if self.rightCar + 1 >= self.carsImages.count {
                    self.rightCar = 0
                } else {
                    self.rightCar += 1
                }

                if self.leftCar + 1 >= self.carsImages.count {
                    self.leftCar = 0
                } else {
                    self.leftCar += 1
                }
                
                if self.currentIndex + 1 >= self.sliderArray.count {
                    self.currentIndex = 0
                } else {
                    self.currentIndex += 1
                }
                
                if self.nextIndex + 1 >= self.sliderArray.count {
                    self.nextIndex = 0
                } else {
                    self.nextIndex += 1
                }
            }
            
        default:
            break
        }

        print("Левый кот \(leftCar)")
        print("Правый кот \(rightCar)")
        print("Текущий кот \(currenCar)")
       print("------------")
    
        
        func rightSwapCarSaving2() {
            
            if currenCar == 0 {
                
                UserDefaults.standard.set(true, forKey: "blue")
                
                UserDefaults.standard.set(false, forKey: "pink")
                UserDefaults.standard.set(false, forKey: "red")
                UserDefaults.standard.set(false, forKey: "green")
                
               
            }
            if currenCar == 1 {
                
                UserDefaults.standard.set(true, forKey: "pink")
                
                UserDefaults.standard.set(false, forKey: "blue")
                UserDefaults.standard.set(false, forKey: "red")
                UserDefaults.standard.set(false, forKey: "green")
            }
            
            if currenCar == 2 {
                
                UserDefaults.standard.set(true, forKey: "red")
                
                UserDefaults.standard.set(false, forKey: "pink")
                UserDefaults.standard.set(false, forKey: "blue")
                UserDefaults.standard.set(false, forKey: "green")
                
            }
            
            if currenCar == 3 {
                UserDefaults.standard.set(true, forKey: "green")
                
                UserDefaults.standard.set(false, forKey: "pink")
                UserDefaults.standard.set(false, forKey: "red")
                UserDefaults.standard.set(false, forKey: "blue")
            }
        }
        
        func leftSwapCarSaving2()
        
        {
            
            if currenCar == 2 {
               
                UserDefaults.standard.set(true, forKey: "blue")
                
                UserDefaults.standard.set(false, forKey: "pink")
                UserDefaults.standard.set(false, forKey: "red")
                UserDefaults.standard.set(false, forKey: "green")
            }
            if currenCar == 3 {
                
                UserDefaults.standard.set(true, forKey: "pink")
                
                UserDefaults.standard.set(false, forKey: "blue")
                UserDefaults.standard.set(false, forKey: "red")
                UserDefaults.standard.set(false, forKey: "green")
            }
            
            if currenCar == 0 {
                
                UserDefaults.standard.set(true, forKey: "red")
                
                UserDefaults.standard.set(false, forKey: "pink")
                UserDefaults.standard.set(false, forKey: "blue")
                UserDefaults.standard.set(false, forKey: "green")
            }
            
            if currenCar == 1 {
                
                UserDefaults.standard.set(true, forKey: "green")
                
                UserDefaults.standard.set(false, forKey: "pink")
                UserDefaults.standard.set(false, forKey: "red")
                UserDefaults.standard.set(false, forKey: "blue")
            }
            
        }
        
        
        
        
        
        
        func rightSwapCarSaving() {
            
            if currenCar == 0 {
                
                UserDefaults.standard.set(CarImages.blueLagoon.rawValue, forKey: "CarImageSave")
                
                print("\(UserDefaults.standard.string(forKey: "CarImageSave") ?? "")")
            }
            if currenCar == 1 {
                
                UserDefaults.standard.set(CarImages.pinkPanter.rawValue, forKey: "CarImageSave")
                print("\(UserDefaults.standard.string(forKey: "CarImageSave") ?? "")")
            }
            
            if currenCar == 2 {
                
                UserDefaults.standard.set(CarImages.redFury.rawValue, forKey: "CarImageSave")
                print("\(UserDefaults.standard.string(forKey: "CarImageSave") ?? "")")
            }
            
            if currenCar == 3 {
                
                UserDefaults.standard.set(CarImages.greenMan.rawValue, forKey: "CarImageSave")
                print("\(UserDefaults.standard.string(forKey: "CarImageSave") ?? "")")
            }
        }
            
            
            func leftSwapCarSaving() {
                
                if currenCar == 2 {
                   
                    UserDefaults.standard.set(CarImages.blueLagoon.rawValue, forKey: "CarImageSave")
                    print("\(UserDefaults.standard.string(forKey: "CarImageSave") ?? "")")
                }
                if currenCar == 3 {
                    
                    UserDefaults.standard.set(CarImages.pinkPanter.rawValue, forKey: "CarImageSave")
                    print("\(UserDefaults.standard.string(forKey: "CarImageSave") ?? "")")
                }
                
                if currenCar == 0 {
                    
                    UserDefaults.standard.set(CarImages.redFury.rawValue, forKey: "CarImageSave")
                    print("\(UserDefaults.standard.string(forKey: "CarImageSave") ?? "")")
                }
                
                if currenCar == 1 {
                    
                    UserDefaults.standard.set(CarImages.greenMan.rawValue, forKey: "CarImageSave")
                    print("\(UserDefaults.standard.string(forKey: "CarImageSave") ?? "")")
                }
                
            }
            
            
        
        func rightSwapCarRecognition() {
            
            print("Сейчас индекс массива слайдера - \(currentIndex)")
            print("Сейчас индекс машинки - \(currenCar)")
            
            if currenCar == 0 {
                print("Blue Car")
                carTypeLabel.text = "Blue lagoon"
            }
            if currenCar == 1 {
                print("Pink Car")
                carTypeLabel.text = "Pink Panter"
            }
            
            if currenCar == 2 {
                print("Red Car")
                carTypeLabel.text = "Red Fury"
            }
            
            if currenCar == 3 {
                print("Green Car")
                carTypeLabel.text = "Green Man"
            }
            
        }
        func leftSwapCarRecognition() {
            if currenCar == 2 {
                print("Blue Car")
                carTypeLabel.text = "Blue lagoon"
            }
            if currenCar == 3 {
                print("Pink Car")
                carTypeLabel.text = "Pink Panter"
            }
            
            if currenCar == 0 {
                print("Red Car")
                carTypeLabel.text = "Red Fury"
            }
            
            if currenCar == 1 {
                print("Green Car")
                carTypeLabel.text = "Green Man"
            }
        }
        
        
}
    
    func gestureCar() {
     let tapGesture = UITapGestureRecognizer()
         tapGesture.numberOfTapsRequired = 2
     tapGesture.addTarget(self, action: #selector(chooseCarTap))
        sliderImageView1.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func chooseCarTap(sender: UITapGestureRecognizer) {
        
        print("Тап в слайдер 1!")
         
        
        
         
        
        //UserDefaults.standard.set(sliderImageView1.image, forKey: "carColor")
    
    }
    
    
    func gestureCar2() {
     let tapGesture = UITapGestureRecognizer()
         tapGesture.numberOfTapsRequired = 2
     tapGesture.addTarget(self, action: #selector(chooseCarTap2))
        sliderImageView2.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func chooseCarTap2(sender: UITapGestureRecognizer) {
        
        print("Тап в слайдер 2!")
        print("Выбрана машинка - \(String(describing: sliderImageView2.image))")
            
    }
    
    
    
    // CHICKEN
    func gestureChicken() {
     let tapGesture = UITapGestureRecognizer()
         tapGesture.numberOfTapsRequired = 2
     tapGesture.addTarget(self, action: #selector(chooseChickenTap))
        sliderChickenImageView1.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func chooseChickenTap(sender: UITapGestureRecognizer) -> Bool {
        
        print("Тап в слайдер 1!")
        UserDefaults.standard.set(true, forKey: "GameMode")
        return true
       
         
         
        
        //UserDefaults.standard.set(sliderImageView1.image, forKey: "carColor")
    
    }
    
    
    func gestureChicken2() {
     let tapGesture = UITapGestureRecognizer()
         tapGesture.numberOfTapsRequired = 2
     tapGesture.addTarget(self, action: #selector(chooseChickenTap2))
        sliderChickenImageView2.addGestureRecognizer(tapGesture)
        
    }
    
    @objc func chooseChickenTap2(sender: UITapGestureRecognizer) -> Bool {
        
        print("Тап в слайдер 2!")
         
        UserDefaults.standard.set(false, forKey: "GameMode")
        return false
         
            
    }
    
    @IBAction func enterYourNameActionFirstTap(_ sender: UITextField) {
         enterYourNameTextFieldUp()
        
    }
    
    
    
    
    
//    @IBAction func enterYourNameActionEnd(_ sender: UITextField) {
//
//
//        print(enterYourNameTextField.text)
//
//        //playerName = UserDefaults.standard.string(forKey: "PlayerName")
//
//
//    }
    
    @IBAction func sumbitNameButtonPressed(_ sender: UIButton) {
        
        //playerName = "\(UserDefaults.standard.string(forKey: "PlayerName") ?? "Player_1")"
        //print(playerName ?? "Mistake")
        //UserDefaults.standard.set(, forKey: <#T##String#>)
    }
    
    
    func enterYourNameTextFieldUp() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear) {
            self.enterYourNameTextField.frame.origin = CGPoint(x: 20, y: 480)
        } completion: { Bool in
        }

        
    }
    func enterYourNameTextFieldDown() {
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear) {
            self.enterYourNameTextField.frame.origin = CGPoint(x: 20, y: 609)
        } completion: { Bool in
        }
        
    }
    
    
    
    
}


extension SettingsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        enterYourNameTextField.text
        UserDefaults.standard.set(enterYourNameTextField.text, forKey: "PlayerName")
        
        playerName = UserDefaults.standard.string(forKey: "PlayerName")
        
         
        playerNameLabel.text = playerName ?? "UnknownPlayer"
        print (playerName)
        
        enterYourNameTextFieldDown()
        enterYourNameTextField.text = nil
        enterYourNameTextField.endEditing(true)
         
        return true
    }
    
}



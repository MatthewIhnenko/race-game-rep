//
//  ResultsViewController.swift
//  RaceGame 1.0
//
//  Created by Matthew on 15.04.22.
//

import UIKit

class ResultsViewController: UIViewController {
    
    
    //@IBOutlet weak var nameLabel: UILabel!
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    
    @IBOutlet weak var name1Label: UILabel!
    @IBOutlet weak var name2Label: UILabel!
    @IBOutlet weak var name3Label: UILabel!
    @IBOutlet weak var result1Label: UILabel!
    @IBOutlet weak var result2Label: UILabel!
    @IBOutlet weak var result3Label: UILabel!
    @IBOutlet weak var date1Label: UILabel!
    @IBOutlet weak var date2Label: UILabel!
    @IBOutlet weak var date3Label: UILabel!
    
    private var nameLabels = [UILabel]()
    private var resultLabels = [UILabel]()
    private var dateLabels = [UILabel]()
    
    
    var player: [Player] = []
    
    let decoder = JSONDecoder()
    let encoder = JSONEncoder()
    
   
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.font = UIFont.buttershine(with: 30)

        tableView.delegate = self
        tableView.dataSource = self
        
        addNameLabelArray()
        addResultLabelArray()
        addDateLabelArray()
        
        addToScores()
       
    hide()
       
    }
    
    func hide() {
        
        name1Label.isHidden = true
        date1Label.isHidden = true
        result1Label.isHidden = true
        
        name2Label.isHidden = true
        date2Label.isHidden = true
        result2Label.isHidden = true
        
        name3Label.isHidden = true
        date3Label.isHidden = true
        result3Label.isHidden = true
        
        
    }
    
    
    private func addDateLabelArray() {
    
        dateLabels.append(date1Label)
        dateLabels.append(date2Label)
        dateLabels.append(date3Label)
        
        
    }
    
    private func addNameLabelArray() {
    
        nameLabels.append(name1Label)
        nameLabels.append(name2Label)
        nameLabels.append(name3Label)
        
        
    }
    
    private func addResultLabelArray() {
        
        resultLabels.append(result1Label)
        resultLabels.append(result2Label)
        resultLabels.append(result3Label)
    }
    
    private func addToScores() {
        if let data = UserDefaults.standard.value(forKey: "info") as? Data {
            do {
               // let playersResult  = try decoder.decode([Player].self, from: data)
                 player  = try decoder.decode([Player].self, from: data)
                 print(player.count)

                
//                var a = 0
//                var i = 0
//                // var c = 0
//                nameLabels[0].text = playersResult[0].name
//                resultLabels[0].text = "\(playersResult[0].result)"
//                dateLabels[0].text = playersResult[0].date
//
//                nameLabels[1].text = playersResult[1].name
//                resultLabels[1].text = "\(playersResult[1].result)"
//                dateLabels[1].text = playersResult[1].date
//
//                nameLabels[2].text = playersResult[2].name
//                resultLabels[2].text = "\(playersResult[2].result)"
//                dateLabels[2].text = playersResult[2].date
                
            } catch {
                print(error.localizedDescription)
            }
            }
        }
    
    
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        
        let startViewController = StartViewController.instantiate()
        dismiss(animated: true)
        
        
    }
    
    func resetDefaults() {
        let defaults = UserDefaults.standard
        let dictionary = defaults.dictionaryRepresentation()
        dictionary.keys.forEach { key in
            defaults.removeObject(forKey: key)
        }
    }
    
    @IBAction func resetButtonAction(_ sender: UIButton) {
        resetDefaults()
    }
    
    }

extension ResultsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return player.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ResultsTableViewCell") as? ResultsTableViewCell else {
            
            fatalError()
        }
        cell.setup(with: player[indexPath.row], row: indexPath.row)
        
        return cell
        
    }
    
    
    
    
}

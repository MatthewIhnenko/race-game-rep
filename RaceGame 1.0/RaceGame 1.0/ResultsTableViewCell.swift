//
//  ResultsTableViewCell.swift
//  RaceGame 1.0
//
//  Created by Matthew on 18.06.22.
//

import UIKit

class ResultsTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var nameLabel: UILabel!
    
    @IBOutlet private weak var resultLabel: UILabel!
    
    @IBOutlet private weak var dateLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        resultLabel.text = "Result"
        nameLabel.text = "Name"
        dateLabel.text = "Date"
    }
    
    func setup (with result: Player, row: Int) {
        
        if row < 3 {
            nameLabel.textColor = .red
        } else {
            nameLabel.textColor = .black
        }
        nameLabel.text = result.name
        resultLabel.text = "\(result.result)"
        dateLabel.text = "\(result.date)"
        
    }
    

}

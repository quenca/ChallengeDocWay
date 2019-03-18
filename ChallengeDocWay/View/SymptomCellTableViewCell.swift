//
//  SymptomCellTableViewCell.swift
//  ChallengeDocWay
//
//  Created by Gustavo Quenca on 15/03/19.
//  Copyright © 2019 Quenca. All rights reserved.
//

import UIKit

class SymptomCellTableViewCell: UITableViewCell {
    
    @IBOutlet weak var symptomLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configure(for result: Symptom) {
        symptomLabel.text = result.name
    }
    
}

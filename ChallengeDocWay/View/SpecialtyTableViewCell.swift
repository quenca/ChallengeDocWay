//
//  SpecialtyTableViewCell.swift
//  ChallengeDocWay
//
//  Created by Gustavo Quenca on 16/03/19.
//  Copyright © 2019 Quenca. All rights reserved.
//

import UIKit

class SpecialtyTableViewCell: UITableViewCell {
    
    @IBOutlet weak var specialtyLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(for result: Specialty) {
        specialtyLabel.text = result.name
    }
}

//
//  ViewController.swift
//  ChallengeDocWay
//
//  Created by Gustavo Quenca on 15/03/19.
//  Copyright © 2019 Quenca. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        selectedSymptoms.removeAll()
        selectedSpecialty = nil
    }
    
}



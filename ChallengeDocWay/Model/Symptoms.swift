//
//  Symptoms.swift
//  ChallengeDocWay
//
//  Created by Gustavo Quenca on 15/03/19.
//  Copyright © 2019 Quenca. All rights reserved.
//

import Foundation

class Symptom: NSObject, Codable {
    let id: Int
    let name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
}

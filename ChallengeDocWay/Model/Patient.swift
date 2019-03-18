//
//  Patient.swift
//  ChallengeDocWay
//
//  Created by Gustavo Quenca on 16/03/19.
//  Copyright © 2019 Quenca. All rights reserved.
//

import Foundation

class Patient: Codable {
    var name: String
    var gender: String
    var dateOfBirth: Date
    var phone: String
    
    init(name: String, gender: String, dateOfBirth: Date, phone: String) {
        self.name = name
        self.gender = gender
        self.dateOfBirth = dateOfBirth
        self.phone = phone
    }
}


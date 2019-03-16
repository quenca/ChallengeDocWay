//
//  Symptoms.swift
//  ChallengeDocWay
//
//  Created by Gustavo Quenca on 15/03/19.
//  Copyright © 2019 Quenca. All rights reserved.
//

import Foundation

class SymptomsList: Codable {
    var symptomsList: [Symptom]?
}

class Symptom: Codable {
    let id: Int
    let name: String
}


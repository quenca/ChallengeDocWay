//
//  Appointment.swift
//  ChallengeDocWay
//
//  Created by Gustavo Quenca on 16/03/19.
//  Copyright © 2019 Quenca. All rights reserved.
//

import Foundation

class Appointment: NSObject, Codable {
    
    let date: Date
    let patient: Patient
    let address: Adress
    var symptoms: [Int]
    let specialty: Specialty
    
    init(date: Date, patient: Patient, address: Adress, symptoms: [Int], specialty: Specialty) {
        self.date = date
        self.patient = patient
        self.address = address
        self.symptoms = symptoms
        self.specialty = specialty
    }
}

class Adress: Codable {
    let street: String
    let number: Int
    let complement: String
    let neighborhood: String
    let cep: String
    let city: String
    let state: String
    
    init(street: String, number: Int, complement: String, neighborhood: String, cep: String, city: String, state: String) {
        self.street = street
        self.number = number
        self.complement = complement
        self.neighborhood = neighborhood
        self.cep = cep
        self.city = city
        self.state = state
    }
}

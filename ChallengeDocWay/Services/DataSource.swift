//
//  DataSource.swift
//  ChallengeDocWay
//
//  Created by Gustavo Quenca on 15/03/19.
//  Copyright © 2019 Quenca. All rights reserved.
//

import Foundation
import UIKit

class DataSource {
    
    // MARK: -Properties
    
    typealias Completion = (Bool) -> Void
    
    private(set) var symptomState: SymptomState = .loading
    private(set) var specialtyState: SpecialtyState = .loading
    
    enum SymptomState {
        case loading
        case noResults
        case results([Symptom])
    }
    
    enum SpecialtyState {
        case loading
        case noResults
        case results([Specialty])
    }
    
    // MARK: -Get URL
    
    func getSymptomsURL () -> URL {
        let urlString = "https://www.mocky.io/v2/5c8bd7ea360000a8438f82fc"
        let url = URL(string: urlString)
        return url!
    }
    
    func getSpecialties() -> URL {
        let urlString = "https://www.mocky.io/v2/5c8c1e0336000044488f842b"
        let url = URL(string: urlString)
        return url!
    }
    
    // MARK: -Parses
    
    func parseSymptoms(data: Data) -> [Symptom]? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode([Symptom].self, from: data)
            return result
        } catch {
            return []
        }
    }
    
    func parseSpecialties(data: Data) -> [Specialty]? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode([Specialty].self, from: data)
            return result
        } catch {
            return []
        }
    }
    
    // MARK: -GET Resquest
    
    func getSymptomsRequest(completion: @escaping Completion) {
        var dataTask: URLSessionDataTask? = nil
        let url = getSymptomsURL()
        let session = URLSession.shared
        
        symptomState = .loading
        
        dataTask = session.dataTask(with: url, completionHandler: { data, response, error in
            var success = false
            var newSymptomState = SymptomState.noResults
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data {
                let symptom = self.parseSymptoms(data: data)
                if let symptoms = symptom {
                    newSymptomState = SymptomState.results(symptoms)
                } else {
                    newSymptomState = SymptomState.noResults
                }
                success = true
            }
            DispatchQueue.main.async {
                self.symptomState = newSymptomState
                completion(success)
            }
        })
        dataTask?.resume()
    }
    
    func getSpecialityRequest(completion: @escaping Completion) {
        var dataTask: URLSessionDataTask? = nil
        let url = getSymptomsURL()
        let session = URLSession.shared
        
        specialtyState = .loading
        
        dataTask = session.dataTask(with: url, completionHandler: { data, response, error in
            var success = false
            var newSpecialtyState = SpecialtyState.noResults
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200, let data = data {
                let speciality = self.parseSpecialties(data: data)
                if let specialties = speciality {
                    newSpecialtyState = SpecialtyState.results(specialties)
                } else {
                    newSpecialtyState = SpecialtyState.noResults
                }
                success = true
            }
            DispatchQueue.main.async {
                self.specialtyState = newSpecialtyState
                completion(success)
            }
        })
        dataTask?.resume()
    }
}

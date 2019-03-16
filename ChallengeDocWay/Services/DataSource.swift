//
//  DataSource.swift
//  ChallengeDocWay
//
//  Created by Gustavo Quenca on 15/03/19.
//  Copyright © 2019 Quenca. All rights reserved.
//

import Foundation

class DataSource {
typealias Completion = (Bool) -> Void
    
    enum SymptomState {
        case loading
        case noResults
        case results([Symptom])
    }
    
    private(set) var state: SymptomState = .noResults
    
    func getSymptomsURL () -> URL {
        let urlString = "https://www.mocky.io/v2/5c8bd7ea360000a8438f82fc"
        let url = URL(string: urlString)
        print(url!)
        return url!
    }
    
    func parseSymptoms(data: Data) -> [Symptom]? {
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode([Symptom].self, from: data)
            print(result)
            return result
        } catch {
            print("JSON Error: \(error)")
            return []
        }
    }
    
    func getSymptomsRequest(completion: @escaping Completion) {
        var dataTask: URLSessionDataTask? = nil
        let url = getSymptomsURL()
        let session = URLSession.shared
        
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
                self.state = newSymptomState
                completion(success)
            }
        })
        dataTask?.resume()
    }
}

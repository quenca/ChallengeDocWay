//
//  SymptomViewController.swift
//  ChallengeDocWay
//
//  Created by Gustavo Quenca on 15/03/19.
//  Copyright © 2019 Quenca. All rights reserved.
//

import UIKit

class SymptomViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var symptoms = [Symptom]()
    
    private let dataSource = DataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UINib(nibName: "SymptomCellTableViewCell", bundle: .main), forCellReuseIdentifier: "SymptomCellTableViewCell")
        
        // Get the request
        dataSource.getSymptomsRequest(completion: { success in
            if !success {
                print("error")
            }
            self.tableView.reloadData()
        })
    }
}

extension SymptomViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if case .results(let list) = dataSource.state {
            return list.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("CellForRowAt")
        
        if case .results(let list) = dataSource.state {
            
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SymptomCellTableViewCell", for: indexPath) as? SymptomCellTableViewCell else {
                return UITableViewCell()
            }
            
            let symptom = list[indexPath.row]
            cell.configure(for: symptom)
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SymptomCellTableViewCell", for: indexPath) as? SymptomCellTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}

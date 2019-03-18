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
    let spinner = UIActivityIndicatorView(style: .whiteLarge)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "SymptomCellTableViewCell", bundle: .main), forCellReuseIdentifier: "SymptomCellTableViewCell")
        
        // Get the request
        dataSource.getSymptomsRequest(completion: { success in
            self.spinner.stopAnimating()
            self.tableView.reloadData()
        })
    }
    
    func createSpinnerView() {
        spinner.color = .black
        spinner.hidesWhenStopped = true
        view.addSubview(spinner)
        
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}

extension SymptomViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch dataSource.symptomState {
        case .loading:
            return 1
            
        case .noResults:
            return 1
            
        case .results(let list):
            return list.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource.symptomState {
        case .loading:
            createSpinnerView()
            spinner.startAnimating()
            return UITableViewCell()
        
        case .noResults:
            self.spinner.stopAnimating()
            let alert = UIAlertController(title: "Error", message: "Not Found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
                (action: UIAlertAction!) -> Void in
                self.navigationController?.popViewController(animated: true);
            }))
            self.present(alert, animated: true, completion: nil)
            
            return UITableViewCell()
            
        case .results(let list):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SymptomCellTableViewCell", for: indexPath) as? SymptomCellTableViewCell else {
                return UITableViewCell()
            }
            let symptom = list[indexPath.row]
            cell.configure(for: symptom)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            if case .results(let list) = dataSource.symptomState {
                let selectedSymptom = list[indexPath.row]
                let symptomAppointment = AppointmentViewController()
                symptomAppointment.selectedSymptom = [selectedSymptom.id]
                self.navigationController?.popViewController(animated: true);
            }
        }
    }
}

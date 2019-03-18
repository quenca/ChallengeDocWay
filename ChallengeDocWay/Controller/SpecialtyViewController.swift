//
//  EspecialityViewController.swift
//  ChallengeDocWay
//
//  Created by Gustavo Quenca on 16/03/19.
//  Copyright © 2019 Quenca. All rights reserved.
//

import UIKit

class SpecialtyViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var allowsSelection = false
    
    private let dataSource = DataSource()
    
    let spinner = UIActivityIndicatorView(style: .whiteLarge)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "SpecialtyTableViewCell", bundle: .main), forCellReuseIdentifier: "SpecialtyTableViewCell")
        
        tableView.allowsSelection = allowsSelection
        
        // Get the request
        dataSource.getSpecialityRequest(completion: { success in
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

// MARK: -Table View Delegate

extension SpecialtyViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch dataSource.specialtyState {
        case .loading:
            return 1
            
        case .noResults:
            return 1
            
        case .results(let list):
            return list.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch dataSource.specialtyState {
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
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "SpecialtyTableViewCell", for: indexPath) as? SpecialtyTableViewCell else {
                return UITableViewCell()
            }
            let spelcialty = list[indexPath.row]
            cell.configure(for: spelcialty)
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard allowsSelection else {
            return
        }
        if let cell = tableView.cellForRow(at: indexPath) {
            if case .results(let list) = dataSource.specialtyState {
                selectedSpecialty = list[indexPath.row]
            }
        }
    }
}

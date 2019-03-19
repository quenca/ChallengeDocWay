//
//  AppointmentViewController.swift
//  ChallengeDocWay
//
//  Created by Gustavo Quenca on 16/03/19.
//  Copyright © 2019 Quenca. All rights reserved.
//

import UIKit

class AppointmentViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameText: UITextField!
    @IBOutlet weak var birthdayText: UITextField!
    @IBOutlet weak var genderText: UITextField!
    @IBOutlet weak var phoneText: UITextField!
    
    @IBOutlet weak var streetText: UITextField!
    @IBOutlet weak var neighborhoodText: UITextField!
    @IBOutlet weak var numberText: UITextField!
    @IBOutlet weak var cepText: UITextField!
    @IBOutlet weak var stateText: UITextField!
    @IBOutlet weak var dateText: UITextField!
    @IBOutlet weak var timeText: UITextField!
    @IBOutlet weak var cityText: UITextField!
    @IBOutlet weak var complement: UITextField!
    
    @IBOutlet weak var symptomButton: UIButton!
    @IBOutlet weak var specialtyButton: UIButton!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    private let dataSource = DataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIResponder.keyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.scrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        scrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
    }
    

    
    override func viewWillAppear(_ animated: Bool) {
        
        // Change the buttons name  after choose Symptoms and Specialty
        if selectedSymptoms.isEmpty {
            symptomButton.setTitle("Escolher Sintomas", for: .normal)
        } else {
            symptomButton.setTitle("\(selectedSymptoms.count) Sintomas Selecionados", for: .normal)
        }
        if let specialtyName = selectedSpecialty?.name {
            specialtyButton.setTitle("\(specialtyName)", for: .normal)
        } else {
            specialtyButton.setTitle("Escolher Especialidade", for: .normal)
        }
    }
    
    @IBAction func addAppointment(_ sender: Any) {
        if nameText.text!.isEmpty || birthdayText.text!.isEmpty ||  genderText.text!.isEmpty ||  phoneText.text!.isEmpty ||  streetText.text!.isEmpty ||  neighborhoodText.text!.isEmpty ||  stateText.text!.isEmpty ||  cepText.text!.isEmpty ||  dateText.text!.isEmpty ||  timeText.text!.isEmpty ||  cityText.text!.isEmpty ||  complement.text!.isEmpty || selectedSymptoms.isEmpty || selectedSpecialty == nil {
            let alert = UIAlertController(title: "Campos Vazios", message: "Preencha todos os campos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            
            let arrayInt = selectedSymptoms.compactMap({ $0.id })
            
            let birthdayString = birthdayText.text!
            let birthdayFormatter = DateFormatter()
            birthdayFormatter.dateFormat = "YYYY-MM-DD"
            let birthdayFromString = birthdayFormatter.date(from: birthdayString)
            
            guard let birthday = birthdayFromString else {
                fatalError("ERROR: Date conversion failed due to mismatched format.")
            }
            
            let dateString = dateText.text!
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-DD"
            let dateFromString = dateFormatter.date(from: dateString)
            
            guard let date = dateFromString else {
                fatalError("ERROR: Date conversion failed due to mismatched format.")
            }
            
            // MARK: -Post Request 
            dataSource.postAppointmentRequest(appointment: Appointment(date: birthday, patient: Patient(name: nameText.text!, gender: genderText.text!, dateOfBirth: date, phone: phoneText.text!), address: Adress(street: streetText.text!, number: Int(numberText.text!)!, complement: complement.text!, neighborhood: neighborhoodText.text!, cep: cepText.text!, city: cityText.text!, state: stateText.text!), symptoms: arrayInt, specialty: Specialty(id: (selectedSpecialty?.id)!, name: "Pediatra")), completion: { success in
                
                let alert = UIAlertController(title: "Solicitação Concluída", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
                    (action: UIAlertAction!) -> Void in
                    self.navigationController?.popViewController(animated: true);
                }))
                self.present(alert, animated: true, completion: nil)
            })
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSymptom" {
            (segue.destination as? SymptomViewController)?.allowsSelection = true
        } else if segue.identifier == "showSpecialty" {
            (segue.destination as? SpecialtyViewController)?.allowsSelection = true
        }
    }
}

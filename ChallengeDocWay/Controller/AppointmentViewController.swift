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
    
    var selectedSymptom: [Int]?
    
    private let dataSource = DataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addAppointment(_ sender: Any) {
     /*   if nameText.text!.isEmpty && birthdayText.text!.isEmpty &&  genderText.text!.isEmpty &&  phoneText.text!.isEmpty &&  streetText.text!.isEmpty &&  neighborhoodText.text!.isEmpty &&  stateText.text!.isEmpty &&  cepText.text!.isEmpty &&  dateText.text!.isEmpty &&  timeText.text!.isEmpty &&  cityText.text!.isEmpty &&  complement.text!.isEmpty {
            let alert = UIAlertController(title: "Campos Vazios", message: "Preencha todos os campos", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            
        }*/
        let birthdayString = birthdayText.text!
        let birthdayFormatter = DateFormatter()
        birthdayFormatter.dateFormat = "YYYY-MM-DD"
        let birthdayFromString = birthdayFormatter.date(from: birthdayString)
        
        let dateString = birthdayText.text!
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DDTHH:MM:SSZ"
        let dateFromString = dateFormatter.date(from: dateString)
        
    /*    dataSource.getAppointmentRequest(appointment: Appointment(date: dateFromString!, patient: Patient(name: nameText.text!, gender: genderText.text!, dateOfBirth: birthdayFromString!, phone: phoneText.text!), address: Adress(street: streetText.text!, number: Int(numberText.text!)!, complement: complement.text!, neighborhood: neighborhoodText.text!, cep: cepText.text!, city: cityText.text!, state: stateText.text!), symptoms: [3], specialty: SpecialtyID(id: 1)), completion: {success in
            print("Sucess")
        })
*/
        print(selectedSymptom![0])
    /*    dataSource.getAppointmentRequest(appointment: Appointment(date: dateFromString!, patient: Patient(name: "Gustavo", gender: "Masculino", dateOfBirth: dateFromString!, phone: "3332332"), address: Adress(street: "Rua", number: 22, complement: "2d", neighborhood: "Bairro", cep: "3322332", city: "Ourinhos", state: "SP"), symptoms: [3], specialty: SpecialtyID(id: 1)), completion: {success in
            let alert = UIAlertController(title: "Solicitação Concluída", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: {
                (action: UIAlertAction!) -> Void in
                self.navigationController?.popViewController(animated: true);
            }))
            self.present(alert, animated: true, completion: nil)
            
      })
         }*/ }
}


//
//  ProfileTableViewController.swift
//  Eda
//
//  Created by Roman Efimov on 26.07.2022.
//

import UIKit
import RealmSwift

class ProfileTableViewController: UITableViewController {
    
    var profileService = ProfileService()
    
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var phoneField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var streetField: UITextField!
    @IBOutlet weak var houseField: UITextField!
    @IBOutlet weak var entranceField: UITextField!
    @IBOutlet weak var flatField: UITextField!
    
    let realm = try! Realm()
    var userModel: Results<UserModel>!
    
    
    private let maxNumberCount = 11
    private let regex = try! NSRegularExpression(pattern: "[\\+\\s-\\(\\)]", options: .caseInsensitive)
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))) //Скрываем клавиатуру
        phoneField.delegate = self
        
        phoneField.keyboardType = .numberPad
        
        setData()
    }
    
    
    private func format(phoneNumber: String, shouldRemoveLastDigit: Bool) -> String {
        guard !(shouldRemoveLastDigit && phoneNumber.count <= 2) else {return "+"}
        let range = NSString(string: phoneNumber).range(of: phoneNumber)
        var number = regex.stringByReplacingMatches(in: phoneNumber, options: [], range: range, withTemplate: "")
        
        if number.count > maxNumberCount {
            let maxIndex = number.index(number.startIndex, offsetBy: maxNumberCount)
            number = String(number[number.startIndex..<maxIndex])
        }
        
        if shouldRemoveLastDigit {
            let maxIndex = number.index(number.startIndex, offsetBy: number.count - 1)
            number = String(number[number.startIndex..<maxIndex])
        }
        
        let maxIndex = number.index(number.startIndex, offsetBy: number.count)
        let regRange = number.startIndex..<maxIndex
        
        if number.count < 7 {
            let pattern = "(\\d)(\\d{3})(\\d+)"
            number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3", options: .regularExpression, range: regRange)
        } else {
            let pattern = "(\\d)(\\d{3})(\\d{3})(\\d{2})(\\d+)"
            number = number.replacingOccurrences(of: pattern, with: "$1 ($2) $3-$4-$5", options: .regularExpression, range: regRange)
        }
        return "+" + number
    }
    
    
    func setData(){
        userModel = realm.objects(UserModel.self)
        if !userModel.isEmpty {
            nameField.text = userModel[0].name
            lastNameField.text = userModel[0].lastName
            phoneField.text = userModel[0].phone
            emailField.text = userModel[0].email
            cityField.text = userModel[0].city
            streetField.text = userModel[0].street
            houseField.text = userModel[0].house
            entranceField.text = userModel[0].entrance
            flatField.text = userModel[0].flat
        }
       
    }
    
    
    
    
    func saveUser(){
        profileService.saveUser(name: nameField.text ?? "",
                                lastName: lastNameField.text ?? "",
                                phone: phoneField.text ?? "",
                                email: emailField.text ?? "",
                                city: cityField.text ?? "",
                                street: streetField.text ?? "",
                                house: houseField.text ?? "",
                                entrace: entranceField.text ?? "",
                                flat: flatField.text ?? "")
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    
    private func validData(){
        if !nameField.text!.isEmpty && !lastNameField.text!.isEmpty && !phoneField.text!.isEmpty && !emailField.text!.isEmpty && !cityField.text!.isEmpty && !streetField.text!.isEmpty  && !houseField.text!.isEmpty && !entranceField.text!.isEmpty && !flatField.text!.isEmpty {

         

                if self.emailField.text!.isValidEmail {
                    saveUser()
                } else {
                    self.showAlert(message: "Email должен соответствовать формату ***@***.***")
                }

            


        } else {
            self.showAlert(message: "Необходимо заполнить все поля")
        }
        
    }
    
    
    
    func showAlert(message: String){
         DispatchQueue.main.async {
             let alert = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
             alert.addAction(UIAlertAction(title: "Ок", style: UIAlertAction.Style.default, handler: nil))
             self.present(alert, animated: true, completion: nil)
         }
     }
    
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
   

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 2
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // #warning Incomplete implementation, return the number of rows
//        switch(section) {
//            case 0: return 4
//            case 1: return 3
//            default: fatalError("Unknown number of sections")
//            }
//    }
//
    
    
    @IBAction func saveButton(_ sender: Any) {
        validData()
    }
    

   

}



extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}





extension ProfileTableViewController: UITextFieldDelegate{
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let fullString = (phoneField.text ?? "") + string
          phoneField.text = format(phoneNumber: fullString, shouldRemoveLastDigit: range.length == 1)
        return false
    }
}







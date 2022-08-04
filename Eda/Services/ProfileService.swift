//
//  ProfileService.swift
//  Eda
//
//  Created by Roman Efimov on 26.07.2022.
//

import Foundation
import RealmSwift

class ProfileService{
    
    var userModel: Results<UserModel>!
    let realm = try! Realm()
    
    
    
    func saveUser(name: String, lastName: String, phone: String, email: String, city: String, street: String, house: String, entrace: String, flat: String){
                
            removeUser()
      
            let userModel = UserModel()
            userModel.name = name
            userModel.lastName = lastName
            userModel.phone = phone
            userModel.email = email
            userModel.city = city
            userModel.street = street
            userModel.house = house
            userModel.entrance = entrace
            userModel.flat = flat
              
            DispatchQueue.main.async {
                try? self.realm.write {
                    self.realm.add(userModel)
                }
            }
    }
    
    
    
    
    func removeUser(){
        userModel = realm.objects(UserModel.self)
        
        try! self.realm.write {
            self.realm.delete(self.userModel)
        }
    }

    
    
    
}

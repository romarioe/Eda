//
//  OrderService.swift
//  Eda
//
//  Created by Roman Efimov on 28.07.2022.
//

import Foundation
import RealmSwift


class OrderService{
    

    var orderModel: Results<OrderRealmModel>!
    let realm = try! Realm()
    
    
    func addToOrders(id: Int){

            let orderRealmModel = OrderRealmModel()
            orderRealmModel.id = id
            
           
            DispatchQueue.main.async {
                try? self.realm.write {
                    self.realm.add(orderRealmModel)
                }
            }
        }



    func removeFromOrders(number: String){
        
        let  orderModel = realm.objects(OrderRealmModel.self)
        
        for (index, value) in orderModel.enumerated() {
            
            if value.id == Int(number) {
                try! self.realm.write {
                    self.realm.delete(orderModel[index])
                    
                }
            }
        }
    }
    
    

}

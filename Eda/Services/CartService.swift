//
//  CartService.swift
//  Eda
//
//  Created by Roman Efimov on 18.07.2022.
//

import Foundation
import RealmSwift

class CartService{
    

    var cartModel: Results<CartModel4>!
    let realm = try! Realm()
    
    func addToCart(name: String, conut: Int, price: Int, comment: String, imageLink: String){
        

        if let index = self.chechExistItemInCart(name: name) {
            let existCartModel = realm.objects(CartModel4.self)
            try! realm.write {
                existCartModel[index].count += 1
                existCartModel[index].totalPrice += price
            }
        } else {
            let cartModel = CartModel4()
            cartModel.name = name
            cartModel.count = conut
            cartModel.price = price
            cartModel.totalPrice = price
            cartModel.comment = comment
            cartModel.imageLink = imageLink
            
           
            DispatchQueue.main.async {
                try? self.realm.write {
                    self.realm.add(cartModel)
                }
            }
        }
    }
    
    
    
    func chechExistItemInCart(name: String) -> Int?{
        var returnIndex: Int?
        let realm = try! Realm()
        
        cartModel = realm.objects(CartModel4.self)
        
        for (index, value) in cartModel.enumerated(){
            if value.name == name {
                returnIndex = index
            }
        }
        return returnIndex
        
    }
    
    
    func getTotalPrice()->Int{
        var totalPrice = 0
        cartModel = realm.objects(CartModel4.self)
        for (_, value) in cartModel.enumerated(){
            totalPrice = totalPrice + value.totalPrice
        }
        return totalPrice
    }
    
    
    
    func removeFromCart(name: String, price: Int){
        print ("remoive")
        
        cartModel = realm.objects(CartModel4.self)
        
        for (index, value) in cartModel.enumerated(){
            if value.name == name {
                if cartModel[index].count > 1 {
                    try! realm.write {
                        cartModel[index].count -= 1
                        cartModel[index].totalPrice -= price
                    }
                    
                } else {
                    
                    try! self.realm.write {
                        self.realm.delete(cartModel[index])
                    
                    }
                    
                }
            }
        }
        
    }
    
    
    
    
    
    func removeAllCart(){
        cartModel = realm.objects(CartModel4.self)
        
        try! self.realm.write {
            self.realm.delete(self.cartModel)
        }
    }
    
    
    
}

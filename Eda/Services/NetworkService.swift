//
//  CategoriesService.swift
//  Eda
//
//  Created by Roman Efimov on 14.07.2022.
//

import Foundation
import RealmSwift


class NetworkService {
    
    let realm = try! Realm()
    var userModel: Results<UserModel>!
    

    
    
    //Категории
    
    let categoryURL = URL(string: "https://eda2.dmgug.ru/wp-json/wc/v2/products/categories?consumer_key=ck_6e74b6e68b07e8062ce720466eeedce0f58666df&consumer_secret=cs_2302605eb51d44add296261c2c17257a5720fa82")!
    
    
    func getCategories(completion: @escaping ([Categories]?) -> Void){
        
        let task = URLSession.shared.dataTask(with: categoryURL) { (data, _, _) in
            guard let data = data else {
                completion(nil)
                return
            }
            
            
            let jsonDecoder = JSONDecoder()
            
            let categories = try? jsonDecoder.decode([Categories].self, from: data)
            completion (categories)
        }
        task.resume()
        
    }
    
    
    
    
    //Меню
    
    
    let menuURL = URL(string: "https://eda2.dmgug.ru/wp-json/wc/v3/products?per_page=100&consumer_key=ck_6e74b6e68b07e8062ce720466eeedce0f58666df&consumer_secret=cs_2302605eb51d44add296261c2c17257a5720fa82")!
    
    
    func getMenu(completion: @escaping ([Menu]?) -> Void){
        
        let task = URLSession.shared.dataTask(with: menuURL) { (data, _, _) in
            guard let data = data else {
                completion(nil)
                return
            }
            
            
            let jsonDecoder = JSONDecoder()
            
            let menu = try? jsonDecoder.decode([Menu].self, from: data)

            completion (menu)
        }
        task.resume()
        
    }
    
    
    
    //Заказ
    
    let orderURL = URL(string: "https://eda2.dmgug.ru/wp-json/wc/v3/orders?consumer_key=ck_6e74b6e68b07e8062ce720466eeedce0f58666df&consumer_secret=cs_2302605eb51d44add296261c2c17257a5720fa82")!
    

    func postOrder(items: [OrderItem], delivery: Bool, completion: @escaping (ResponseModel?) -> Void) {
        
        userModel = realm.objects(UserModel.self)
       
        
        let encoder = JSONEncoder()
        
        
        let billing = Billing(first_name: userModel[0].name,
                              last_name: userModel[0].lastName,
                              address_1: "Улица " + userModel[0].street,
                              address_2: "Дом " + userModel[0].house + " Подъезд " + userModel[0].entrance + " Квартира " + userModel[0].flat,
                              city: userModel[0].city,
                              state: "",
                              postcode: "",
                              country: "Россия",
                              email: userModel[0].email,
                              phone: userModel[0].phone)
        
        
        guard let shipping = setDeliveryInfo(delivery: delivery) else {return}
        
        guard let shippingLines = setDeviveryPrice(delivery: delivery) else {return}
        
        let order = Order(paymentMethod: "bacs", paymentMethodTitle: "Direct Bank Transfer", setPaid: true, billing: billing, shipping: shipping, lineItems: items, shippingLines: [shippingLines])
        

        let jsonData = try! encoder.encode(order)

        var request = URLRequest(url: orderURL)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        request.httpBody = jsonData

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data, error == nil else {
                    print(error?.localizedDescription ?? "No data")
                    return
                }
            let jsonDecoder = JSONDecoder()
            
            let responseData = try? jsonDecoder.decode(ResponseModel.self, from: data)
            completion (responseData)
        }
        task.resume()
    }
    
    
    func setDeliveryInfo(delivery: Bool) -> Shipping?{
        var shipping: Shipping?
        if delivery{
            shipping = Shipping(first_name: userModel[0].name,
                                last_name: userModel[0].lastName,
                                address_1: "Улица " + userModel[0].street,
                                address_2: "Дом " + userModel[0].house + " Подъезд " + userModel[0].entrance + " Квартира " + userModel[0].flat,
                                city: userModel[0].city,
                                state: "",
                                postcode: "",
                                country: "Россия")
        } else {
            
            shipping = Shipping(first_name: "",
                                last_name: "",
                                address_1: "Самовывоз",
                                address_2: "",
                                city: "",
                                state: "",
                                postcode: "",
                                country: "")
            
        }
        return shipping
    }
    
    
    func setDeviveryPrice(delivery: Bool) -> ShipingLines?{
        var shippingLines: ShipingLines?
        if delivery {
             shippingLines = ShipingLines(method_id: "flat_rate", method_title: "Flat Rate", total: "10.00")
        } else {
            shippingLines = ShipingLines(method_id: "flat_rate", method_title: "Flat Rate", total: "0")
        }
        
        return shippingLines
    }
    
    
    
    
    
    
    
    //Статус заказа
    
    func checkStatus(id: Int, completion: @escaping (ResponseModel?) -> Void){
        let strId = String(id)
        let statusURL = URL(string: "https://eda2.dmgug.ru/wp-json/wc/v3/orders/" + strId + "?consumer_key=ck_6e74b6e68b07e8062ce720466eeedce0f58666df&consumer_secret=cs_2302605eb51d44add296261c2c17257a5720fa82")!
        
        let task = URLSession.shared.dataTask(with: statusURL) { (data, _, _) in
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            let responseModel = try? jsonDecoder.decode(ResponseModel.self, from: data)
            completion (responseModel)
        }
        task.resume()
    }
    
    
    
}

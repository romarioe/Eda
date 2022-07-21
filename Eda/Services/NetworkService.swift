//
//  CategoriesService.swift
//  Eda
//
//  Created by Roman Efimov on 14.07.2022.
//

import Foundation


class NetworkService {
    
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
    
    
    let menuURL = URL(string: "https://eda2.dmgug.ru/wp-json/wc/v3/products?consumer_key=ck_6e74b6e68b07e8062ce720466eeedce0f58666df&consumer_secret=cs_2302605eb51d44add296261c2c17257a5720fa82")!
    
    
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
    
    
    
    
}

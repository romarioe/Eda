//
//  MenuPresenter.swift
//  Eda
//
//  Created by Roman Efimov on 14.07.2022.
//

import Foundation

class MenuPresenter{
    
    weak private var menuInputDelegate: MenuInputDelegate?
    
    var networkService = NetworkService()
    var cartService = CartService()
    
    
    func setMenuInputDelegate(menuInputDelegate: MenuInputDelegate?){
        self.menuInputDelegate = menuInputDelegate
    }
}

extension MenuPresenter: MenuOutputDelegate{

    
    func getTotalPrice() {
        let totalPrice = cartService.getTotalPrice()
        let priceString = String(totalPrice)
        self.menuInputDelegate?.setupBage(value: priceString)
        
    }
    
    func getCategories() {
//        networkService.getCategories { categories in
//            guard let categories = categories else {
//                return
//            }
           
          //  guard let ctegoriesForDisplay = self.makeCategoriesForDisplay(categories: categories) else {return}
          //  self.menuInputDelegate?.setupCategories(categories: ctegoriesForDisplay)
 //       }
    }
    
    
    
//    func makeCategoriesForDisplay(categories: [Categories]) -> [Categories]?{
//        var returnArray: [Categories] = []
//        for category in categories {
//            if category.count != 0{
//                returnArray.append(category)
//                print ("Name = ", category.name, " Count = ", category.count)
//
//            }
//        }
//
//        return returnArray
//    }
    
    
    
    
    
    
    
    func getMenu() {
        networkService.getMenu { menu in
            guard let menu = menu else {
                return
            }
            self.menuInputDelegate?.setupMenu(menu: menu)
            guard let categories = self.makeCategoriesForDisplay(menu: menu) else {return}
            self.menuInputDelegate?.setupCategories(categories: categories)
            
        }
    }
    
    
    
    
    func makeCategoriesForDisplay(menu: [Menu]) -> [Categories]?{
        var returnArray: [Categories] = []
        var lastIndex = 0
        
        for (index, value) in menu.enumerated(){
            
            if index == 0 {
                let category = Categories(name: value.categories[0].name, count: 1)
                returnArray.append(category)
            } else
            
            if menu[index].categories[0].name == menu[index-1].categories[0].name {
                returnArray[lastIndex].count += 1

            } else {
                let category = Categories(name: value.categories[0].name, count: 1)
                returnArray.append(category)
                lastIndex += 1
            }
                
           
        }
        return returnArray
    }
    
    
    
}

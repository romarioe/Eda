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
    
    var menuForDisplay: [MenuForDisplay] = []
    
    var prices: [String] = []
    
    
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
            self.makeMenuForDisplay(menu: menu)
            guard let categories = self.makeCategoriesForDisplay(menu: menu) else {return}
            self.menuInputDelegate?.setupCategories(categories: categories)
        }
    }
 
    
    
    func makeMenuForDisplay(menu: [Menu]){
        menuForDisplay.removeAll()
        for item in menu {
            prices.removeAll()
            if  !item.attributes.isEmpty {
                print ("Название = ", item.name)
                self.getVariativePrice(string: item.priceHTML)
            } else {
                prices.append(item.price)
            }
            let menuItem = MenuForDisplay(id: item.id,
                                          name: item.name,
                                          description: item.description,
                                          images: item.images,
                                          categories: item.categories,
                                          attributes: item.attributes,
                                          price: prices)
            menuForDisplay.append(menuItem)
            print (menuForDisplay)
            //print("Цена = ", prices)
            
        }
        self.menuInputDelegate?.setupMenu(menu: menuForDisplay)
       
    }
    
    

    
    func getVariativePrice(string: String){
        var firstIndex: Int?
        var endIndex: Int?
        
        if let range: Range<String.Index> = string.range(of: "<bdi>") {
            firstIndex = string.distance(from: string.startIndex, to: range.lowerBound) + 5
        }
        else {
           // print("substring not found")
        }
        
        
        if let range: Range<String.Index> = string.range(of: "<sup>") {
            endIndex = string.distance(from: string.startIndex, to: range.lowerBound) - 1
        }
        else {
           // print("substring not found")
        }
        guard let firstIndex = firstIndex else {return}
        guard let endIndex = endIndex else {return}
        prices.append(string[firstIndex...endIndex])
        let newString = string[endIndex+5...string.count-1]
    
        getVariativePrice(string: newString)
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


extension String {
  subscript(_ i: Int) -> String {
    let idx1 = index(startIndex, offsetBy: i)
    let idx2 = index(idx1, offsetBy: 1)
    return String(self[idx1..<idx2])
  }

  subscript (r: Range<Int>) -> String {
    let start = index(startIndex, offsetBy: r.lowerBound)
    let end = index(startIndex, offsetBy: r.upperBound)
    return String(self[start ..< end])
  }

  subscript (r: CountableClosedRange<Int>) -> String {
    let startIndex =  self.index(self.startIndex, offsetBy: r.lowerBound)
    let endIndex = self.index(startIndex, offsetBy: r.upperBound - r.lowerBound)
    return String(self[startIndex...endIndex])
  }
}

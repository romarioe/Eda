//
//  MenuOutputDelegate.swift
//  Eda
//
//  Created by Roman Efimov on 14.07.2022.
//

import Foundation

protocol MenuOutputDelegate: AnyObject{
    func getCategories()
    func getMenu()
    func getTotalPrice()
}

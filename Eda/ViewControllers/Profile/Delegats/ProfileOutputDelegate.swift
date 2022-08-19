//
//  ProfileOutputDelegate.swift
//  Eda
//
//  Created by Roman Efimov on 05.08.2022.
//

import Foundation

protocol ProfileOutputDelegate: AnyObject{
    func getOrders()
    
    func getUser()
    
    func removeOrder(number: String)
}

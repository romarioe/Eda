//
//  ProfileInputDelegats.swift
//  Eda
//
//  Created by Roman Efimov on 05.08.2022.
//

import Foundation

protocol ProfileInputDelegate: AnyObject{
    func setOrders(responseModel: [ResponseModel])
    func setUser(name: String, phone: String, address: String)
}

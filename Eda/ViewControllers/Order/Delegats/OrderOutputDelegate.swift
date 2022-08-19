//
//  OrderOutputDelegate.swift
//  Eda
//
//  Created by Roman Efimov on 10.08.2022.
//

import Foundation

protocol OrderOutputDelegate: AnyObject{
    func checkOrderStatus(id: Int)
    func stopStatusUpdate()

}

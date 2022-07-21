//
//  CartModel.swift
//  Eda
//
//  Created by Roman Efimov on 18.07.2022.
//

import Foundation
import RealmSwift

class CartModel4: Object {
//    Comparable
//    static func < (lhs: HistoryVisitedThreadsRealm, rhs: HistoryVisitedThreadsRealm) -> Bool {
//        return lhs.timestamp < rhs.timestamp
//    }
 
    @objc dynamic var name = ""
    @objc dynamic var count = 0
    @objc dynamic var totalPrice = 0
    @objc dynamic var price = 0
    @objc dynamic var comment = ""
    @objc dynamic var imageLink = ""
}

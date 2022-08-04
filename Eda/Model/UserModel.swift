//
//  UserModel.swift
//  Eda
//
//  Created by Roman Efimov on 26.07.2022.
//


import Foundation
import RealmSwift

class UserModel: Object {
//    Comparable
//    static func < (lhs: HistoryVisitedThreadsRealm, rhs: HistoryVisitedThreadsRealm) -> Bool {
//        return lhs.timestamp < rhs.timestamp
//    }
    @objc dynamic var name = ""
    @objc dynamic var lastName = ""
    @objc dynamic var phone = ""
    @objc dynamic var email = ""
    @objc dynamic var city = ""
    @objc dynamic var street = ""
    @objc dynamic var house = ""
    @objc dynamic var entrance = ""
    @objc dynamic var flat = ""
    
}

//
//  MenuDetailModel.swift
//  Eda
//
//  Created by Roman Efimov on 15.07.2022.
//

import Foundation

struct MenuDetail: Decodable {
    let id: Int
    let name: String
    let description: String
    let imageLink: String
    let price: [String]
    let options: [String]
}

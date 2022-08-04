//
//  MenuModel.swift
//  Eda
//
//  Created by Roman Efimov on 14.07.2022.
//

import Foundation

struct Menu: Decodable {
    let id: Int
    let name: String
    let description: String
    let images: [Images]
    let categories: [MenuCategories]
    let attributes: [Attributes]
    let price: String
}


struct Images: Decodable {
    let src: String
}


struct MenuCategories: Decodable {
    let name: String
}


struct Attributes: Decodable {
    let options: [String]
}





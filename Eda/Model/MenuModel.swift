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
    let priceHTML: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case images
        case categories
        case attributes
        case price
        case priceHTML = "price_html"
    }
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





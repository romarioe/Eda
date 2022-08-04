//
//  ResponceModel.swift
//  Eda
//
//  Created by Roman Efimov on 28.07.2022.
//

import Foundation

struct ResponseModel: Decodable, Equatable {
    static func == (lhs: ResponseModel, rhs: ResponseModel) -> Bool {
        lhs.status == rhs.status
    }
    
    let id: Int
    let number: String
    let status: String
    let lineItems: [LineItems]
    let total: String
    let dateCreated: String
    
    private enum CodingKeys: String, CodingKey {
        case id
        case number
        case status
        case lineItems = "line_items"
        case total
        case dateCreated = "date_created"
    }
}


struct LineItems: Decodable{
    let id: Int
    let name: String
    let quantity: Int
    
}

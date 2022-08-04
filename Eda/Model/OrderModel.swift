//
//  OrderModel.swift
//  Eda
//
//  Created by Roman Efimov on 25.07.2022.
//

import Foundation


struct Order: Encodable {
    let paymentMethod: String
    let paymentMethodTitle: String
    let setPaid: Bool
    let billing: Billing
    let shipping: Shipping
    let lineItems: [OrderItem]
    let shippingLines: [ShipingLines]
    
    
    private enum CodingKeys: String, CodingKey {
        case paymentMethod = "payment_method"
        case paymentMethodTitle = "payment_method_title"
        case setPaid = "set_paid"
        case billing
        case shipping
        case lineItems = "line_items"
        case shippingLines = "shipping_lines"
        
    }


}


struct Billing: Encodable {
    let first_name: String
    let last_name: String
    let address_1: String
    let address_2: String
    let city: String
    let state: String
    let postcode: String
    let country: String
    let email: String
    let phone: String
}



struct Shipping: Encodable {
    let first_name: String
    let last_name: String
    let address_1: String
    let address_2: String
    let city: String
    let state: String
    let postcode: String
    let country: String
}



struct ShipingLines: Encodable {
    let method_id: String
    let method_title: String
    let total: String
}




struct OrderItem: Encodable {
    var id: Int
    var quantity: Int
    
    private enum CodingKeys: String, CodingKey {
        case id = "product_id"
        case quantity
    }

}

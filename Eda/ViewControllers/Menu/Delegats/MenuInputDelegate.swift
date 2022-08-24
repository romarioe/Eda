//
//  MenuInputDelegate.swift
//  Eda
//
//  Created by Roman Efimov on 14.07.2022.
//

import Foundation

protocol MenuInputDelegate: AnyObject{
    func setupCategories(categories: [Categories])
    func setupMenu(menu: [MenuForDisplay])
    func setupBage(value: String)
}

//
//  MenuModel.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 05.07.2023.
//

import Foundation

struct MenuModel: Codable {
    let dishes: [Dish]
}

struct Dish: Codable {
    let id: Int
    let name: String
    let price, weight: Int
    let description: String
    let imageURL: URL
    let tegs: [String]

    enum CodingKeys: String, CodingKey {
        case id, name, price, weight, description
        case imageURL = "image_url"
        case tegs
    }
}

//
//  FoodCategoriesModel.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 02.07.2023.
//

import Foundation

struct FoodCategoriesModel: Codable {
    let сategories: [FoodCategory]
}

struct FoodCategory: Codable {
    let id: Int
    let name: String
    let imageURL: String?
    var dishes: [Dish]?

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
        case dishes
    }
}

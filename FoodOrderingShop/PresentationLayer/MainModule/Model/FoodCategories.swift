//
//  FoodCategories.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 02.07.2023.
//

import Foundation

struct FoodCategories: Codable {
    let сategories: [FoodСategory]
}

struct FoodСategory: Codable {
    let id: Int
    let name: String
    let imageURL: String?

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
    }
}

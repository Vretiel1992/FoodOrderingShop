//
//  FoodCategoriesModel.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 02.07.2023.
//

import Foundation

struct FoodCategoriesModel: Codable {
    let сategories: [FoodCategoryModel]
}

struct FoodCategoryModel: Codable {
    let id: Int
    let name: String
    let imageURL: URL?

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
    }
}

//
//  FoodCategoryEntity.swift
//  FoodOrderingShop
//
//  Created by Gregory Berngardt on 16.08.2023.
//

import Foundation

struct FoodCategoryEntity: Codable {
    let id: Int
    let name: String
    let imageURL: URL?

    enum CodingKeys: String, CodingKey {
        case id, name
        case imageURL = "image_url"
    }
}

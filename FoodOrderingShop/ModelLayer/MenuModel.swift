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
    let imageURL: String
    let tegs: [Teg]

    enum CodingKeys: String, CodingKey {
        case id, name, price, weight, description
        case imageURL = "image_url"
        case tegs
    }
}

enum Teg: String, Codable, CaseIterable {
    case allMenu = "Все меню"
    case salads = "Салаты"
    case withRice = "С рисом"
    case withFish = "С рыбой"
}

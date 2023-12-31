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

func processTegs(_ dishes: [Dish]) -> [Teg] {
    var tags = Set<String>()
    for dish in dishes {
        for tag in dish.tegs {
            tags.insert(tag)
        }
    }

    var result: [Teg] = [.allMenu]
    for tag in tags {
        if tag == Teg.allMenu.string {
            continue
        }
        result.append(.custom(tag))
    }
    result.sort { $0.string < $1.string }
    return result
}

enum Teg {
    case allMenu
    case custom(String)

    var string: String {
        switch self {
        case .allMenu: return "Все меню"
        case let .custom(value): return value
        }
    }
}

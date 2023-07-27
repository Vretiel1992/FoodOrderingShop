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

enum Teg {
    case allMenu
    case custom(String)

    var string: String {
        switch self {
        case .allMenu: return Strings.MenuModel.tagNameAllMenu
        case let .custom(value): return value
        }
    }
}

extension Teg: Comparable {

    static func < (lhs: Self, rhs: Self) -> Bool {
        let sortOrder: [Teg] = [
            .allMenu,
            .custom(Strings.MenuModel.tagNameSalads),
            .custom(Strings.MenuModel.tagNameWithRice),
            .custom(Strings.MenuModel.tagNameWithFish)
        ]

        guard let lhsIndex = sortOrder.firstIndex(of: lhs),
              let rhsIndex = sortOrder.firstIndex(of: rhs) else {
            return false
        }

        return lhsIndex < rhsIndex
    }
}

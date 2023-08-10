//
//  TagModel.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 08.08.2023.
//

import Foundation

struct TagModel {
    enum Teg: Comparable {
        case allMenu
        case custom(String)

        var string: String {
            switch self {
            case .allMenu:
                return Strings.MenuModel.tagNameAllMenu
            case let .custom(value):
                return value
            }
        }
    }

    let teg: Teg
    var isSelected: Bool
}

extension TagModel: Comparable {

    static func < (lhs: Self, rhs: Self) -> Bool {
        let sortOrder: [TagModel] = [
            TagModel(teg: .allMenu, isSelected: false),
            TagModel(teg: .custom(Strings.MenuModel.tagNameSalads), isSelected: false),
            TagModel(teg: .custom(Strings.MenuModel.tagNameWithRice), isSelected: false),
            TagModel(teg: .custom(Strings.MenuModel.tagNameWithFish), isSelected: false)
        ]

        guard let lhsIndex = sortOrder.firstIndex(where: { $0.teg == lhs.teg }),
              let rhsIndex = sortOrder.firstIndex(where: { $0.teg == rhs.teg }) else {
            return false
        }

        return lhsIndex < rhsIndex
    }
}

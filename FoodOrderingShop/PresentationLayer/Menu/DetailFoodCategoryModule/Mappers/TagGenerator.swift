//
//  TagGenerator.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 27.07.2023.
//

import Foundation

struct TagGenerator {

    func process(_ dishes: [Dish]) -> [TagModel] {
        var tags = Set<String>()

        dishes.forEach { $0.tegs.forEach { tags.insert($0) } }

        let result = Array(tags).map {
            $0 == TagModel.Teg.allMenu.string
            ? TagModel(teg: TagModel.Teg.allMenu, isSelected: false)
            : TagModel(teg: TagModel.Teg.custom($0), isSelected: false)
        }

        return result.sorted()
    }
}

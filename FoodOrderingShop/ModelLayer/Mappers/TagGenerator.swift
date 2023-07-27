//
//  TagGenerator.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 27.07.2023.
//

import Foundation

struct TagGenerator {

    func process(_ dishes: [Dish]) -> [Teg] {
        var tags = Set<String>()

        dishes.forEach { $0.tegs.forEach { tags.insert($0) } }

        let result = Array(tags).map {
            $0 == Teg.allMenu.string ? Teg.allMenu : Teg.custom($0)
        }
        return result.sorted()
    }
}

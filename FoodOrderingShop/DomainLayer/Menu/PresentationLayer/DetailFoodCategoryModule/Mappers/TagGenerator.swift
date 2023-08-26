//
//  TagGenerator.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 27.07.2023.
//

import Foundation

struct TagGenerator {

    func process(_ dishes: [DishModel]) -> [TagModel] {

        var tags = Set<TagModel>()

        dishes.forEach {
            $0.tags.forEach {
                tags.insert($0)
            }
        }

        return tags.sorted()
    }
}

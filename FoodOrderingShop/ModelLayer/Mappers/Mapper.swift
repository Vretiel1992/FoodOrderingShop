//
//  Mapper.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 07.07.2023.
//

import Foundation

class Mapper {

    func map(_ currentTag: Teg, _ dishes: [Dish]) -> [DishCollectionViewCell.Model] {
        dishes.compactMap {
            guard $0.tegs.contains(currentTag.string) else { return nil }
            let itemData = DishCollectionViewCell.Model(
                dishName: $0.name,
                dishImageURL: $0.imageURL
            )
            return itemData
        }
    }
}

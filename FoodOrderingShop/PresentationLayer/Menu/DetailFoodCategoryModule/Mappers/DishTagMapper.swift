//
//  DishTagMapper.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 27.07.2023.
//

import Foundation

final class DishTagMapper: Mappable {

    func map(_ dishTag: TagModel) -> DishTagCollectionViewCell.Model {
        DishTagCollectionViewCell.Model(
            dishTagName: dishTag.teg.string,
            selected: dishTag.isSelected
        )
    }
}

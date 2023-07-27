//
//  DishTagMapper.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 27.07.2023.
//

import Foundation

class DishTagMapper: Mappable {

    func map(_ dishTag: Teg) -> DishTagCollectionViewCell.Model {
        DishTagCollectionViewCell.Model(dishTagName: dishTag.string)
    }
}

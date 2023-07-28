//
//  DishMapper.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 27.07.2023.
//

import Foundation

class DishMapper: Mappable {

    func map(_ dish: Dish) -> DishCollectionViewCell.Model {
        DishCollectionViewCell.Model(
            dishName: dish.name,
            dishImageURL: dish.imageURL
        )
    }
}

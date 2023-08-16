//
//  DishMapper.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 27.07.2023.
//

import Foundation

final class DishMapper: Mappable {

    func map(_ dish: Dish) -> DishCollectionViewCell.Model {
        DishCollectionViewCell.Model(
            id: dish.id,
            dishName: dish.name,
            dishImageURL: dish.imageURL
        )
    }
}

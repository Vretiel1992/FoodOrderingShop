//
//  BasketDishMapper.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 16.08.2023.
//

import Foundation

final class BasketDishMapper: Mappable {

    func map(_ dish: Dish) -> BasketTableViewCell.Model {
        BasketTableViewCell.Model(
            dishImageURL: dish.imageURL,
            dishName: dish.name,
            dishPrice: dish.price,
            dishWeight: dish.weight
        )
    }
}

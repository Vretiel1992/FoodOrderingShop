//
//  SelectedDishMapper.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 27.07.2023.
//

import Foundation

final class SelectedDishMapper: Mappable {

    func map(_ selectedDish: DishModel) -> DishView.Model {
        DishView.Model(
            dishImageURL: selectedDish.imageURL,
            dishName: selectedDish.name,
            dishPrice: selectedDish.price,
            dishWeight: selectedDish.weight,
            dishDescription: selectedDish.description,
            isFavorite: selectedDish.isFavorite,
            inBasket: selectedDish.inBasket
        )
    }
}

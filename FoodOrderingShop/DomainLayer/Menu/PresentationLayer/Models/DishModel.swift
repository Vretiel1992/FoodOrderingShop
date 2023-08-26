//
//  Dish.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 14.08.2023.
//

import Foundation

struct DishModel {
    let id: Int
    let name: String
    let price, weight: Int
    let description: String
    let imageURL: URL
    var isFavorite: Bool
    var inBasket: Bool
    let tags: [TagModel]
}

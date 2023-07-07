//
//  Mapper.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 07.07.2023.
//

import Foundation

protocol MapperProtocol {
    func map(_ categories: [FoodCategory]) -> [MainTableViewCell.Model]
    func map(_ dishTags: [Teg]) -> [DishTagCollectionViewCell.Model]
    func map(_ dishes: [Dish]) -> [DishCollectionViewCell.Model]
}

class Mapper: MapperProtocol {
    func map(_ categories: [FoodCategory]) -> [MainTableViewCell.Model] {
        categories.map {
            MainTableViewCell.Model(
                foodCategoryName: $0.name,
                foodCategoryImageURL: $0.imageURL
            )
        }
    }
    func map(_ dishTags: [Teg]) -> [DishTagCollectionViewCell.Model] {
        dishTags.map {
            DishTagCollectionViewCell.Model(dishTagName: $0.string)
        }
    }

    func map(_ dishes: [Dish]) -> [DishCollectionViewCell.Model] {
        dishes.map {
            DishCollectionViewCell.Model(
                dishName: $0.name,
                dishImageURL: $0.imageURL
            )
        }
    }
}

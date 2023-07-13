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
    func map(_ currentTag: Teg, _ dishes: [Dish]) -> [DishCollectionViewCell.Model]
}

class Mapper: MapperProtocol {
    func map(_ categories: [FoodCategory]) -> [MainTableViewCell.Model] {
        categories.map {
            var categoryName: String
            if $0.name == "Пекарни и кондитерское",
               let range = $0.name.range(of: " ") {
                let firstWord = $0.name.prefix(upTo: range.lowerBound)
                let remainingText = $0.name.suffix(from: range.upperBound)
                categoryName = "\(firstWord)\n\(remainingText)"
            } else {
                categoryName = $0.name
            }

            let cellData = MainTableViewCell.Model(
                foodCategoryName: categoryName,
                foodCategoryImageURL: $0.imageURL
            )

            return cellData
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

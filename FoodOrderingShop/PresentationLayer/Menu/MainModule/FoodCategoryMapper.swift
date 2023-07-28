//
//  FoodCategoryMapper.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 27.07.2023.
//

import Foundation

class FoodCategoryMapper: Mappable {

    func map(_ inputModel: FoodCategory) -> MainTableViewCell.Model {
        var categoryName: String
        if inputModel.name == "Пекарни и кондитерское",
           let range = inputModel.name.range(of: " ") {
            let firstWord = inputModel.name.prefix(upTo: range.lowerBound)
            let remainingText = inputModel.name.suffix(from: range.upperBound)
            categoryName = "\(firstWord)\n\(remainingText)"
        } else {
            categoryName = inputModel.name
        }

        let cellData = MainTableViewCell.Model(
            foodCategoryName: categoryName,
            foodCategoryImageURL: inputModel.imageURL
        )

        return cellData
    }
}

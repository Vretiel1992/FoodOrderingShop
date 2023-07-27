//
//  Mappable.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 27.07.2023.
//

import Foundation

protocol Mappable {

    associatedtype InputModel
    associatedtype ResultModel

    func map(_ inputModel: InputModel) -> ResultModel
}

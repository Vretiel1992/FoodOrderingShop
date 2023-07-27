//
//  Configurable.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 27.07.2023.
//

import Foundation

protocol Configurable {

    associatedtype Model

    func configure(with model: Model)
}

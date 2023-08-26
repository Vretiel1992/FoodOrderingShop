//
//  BasketManager.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 14.08.2023.
//

import Foundation

protocol BasketManagerProtocol {

    func getDishes() -> [DishModel]
    func add(dish: DishModel)
    func remove(dish: DishModel)
    func checkout()
    func subscribe()
}

final class BasketManager: BasketManagerProtocol {

    // MARK: - Private Properties

    private let networkManager: NetworkManagerProtocol
    private var dishes: [DishModel] = []

    // MARK: - Initializers

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    // MARK: - Protocol Methods

    func getDishes() -> [DishModel] {
        dishes
    }

    func add(dish: DishModel) {
        dishes.append(dish)
    }

    func remove(dish: DishModel) {

    }

    func checkout() {

    }

    func subscribe() {

    }
}

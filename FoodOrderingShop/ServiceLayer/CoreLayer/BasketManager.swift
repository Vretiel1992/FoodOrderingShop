//
//  BasketManager.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 14.08.2023.
//

import Foundation

protocol BasketManagerProtocol {

    init(networkManager: NetworkManagerProtocol)

    func getDishes() -> [Dish]
    func add(dish: Dish)
    func remove(dish: Dish)
    func checkout()
    func subscribe()
}

final class BasketManager: BasketManagerProtocol {

    // MARK: - Private Properties

    private let networkManager: NetworkManagerProtocol
    private var dishes: [Dish] = []

    // MARK: - Initializers

    required init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    // MARK: - Protocol Methods

    func getDishes() -> [Dish] {
        dishes
    }

    func add(dish: Dish) {
        dishes.append(dish)
    }

    func remove(dish: Dish) {

    }

    func checkout() {

    }

    func subscribe() {

    }
}

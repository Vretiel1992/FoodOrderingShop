//
//  BasketPresenter.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 15.08.2023.
//

import Foundation

protocol BasketPresenterProtocol {
    init(
        view: BasketViewProtocol,
        basketManager: BasketManagerProtocol
    )
    func viewDidLoad()
}

final class BasketPresenter: BasketPresenterProtocol {

    // MARK: - Private Properties

    private weak var view: BasketViewProtocol?
    private let basketManager: BasketManagerProtocol
    private let basketDishMapper = BasketDishMapper()
    private var dishes: [Dish] = [] {
        didSet {
            view?.update(with: dishes.map(basketDishMapper.map))
        }
    }

    required init(
        view: BasketViewProtocol,
        basketManager: BasketManagerProtocol
    ) {
        self.view = view
        self.basketManager = basketManager
    }

    func viewDidLoad() {
        dishes = basketManager.getDishes()
        view?.update(with: dishes.map(basketDishMapper.map))
    }
}

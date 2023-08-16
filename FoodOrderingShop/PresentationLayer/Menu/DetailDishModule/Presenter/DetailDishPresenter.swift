//
//  DetailDishPresenter.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 12.07.2023.
//

import Foundation

protocol DetailDishPresenterProtocol: AnyObject {
    init(
        view: DetailDishViewProtocol,
        router: DetailDishRouterProtocol,
        basketManager: BasketManagerProtocol,
        dish: Dish
    )
    func viewDidLoad()
    func didTapAddToBasketButton()
    func didTapFavoritesButton()
    func didTapDismissButton()
}

final class DetailDishPresenter: DetailDishPresenterProtocol {

    // MARK: - Private Properties

    private weak var view: DetailDishViewProtocol?
    private let router: DetailDishRouterProtocol
    private let basketManager: BasketManagerProtocol
    private var dish: Dish {
        didSet {
            view?.update(with: selectedDishMapper.map(dish))
        }
    }
    private let selectedDishMapper = SelectedDishMapper()

    // MARK: - Initializers

    required init(
        view: DetailDishViewProtocol,
        router: DetailDishRouterProtocol,
        basketManager: BasketManagerProtocol,
        dish: Dish
    ) {
        self.view = view
        self.router = router
        self.basketManager = basketManager
        self.dish = dish
    }

    // MARK: - Protocol Methods

    func viewDidLoad() {
        view?.update(with: selectedDishMapper.map(dish))
    }

    func didTapAddToBasketButton() {
        dish.inBasket.toggle()
        basketManager.add(dish: dish)
    }

    func didTapFavoritesButton() {
        dish.isFavorite.toggle()
    }

    func didTapDismissButton() {
        router.dismiss()
    }
}

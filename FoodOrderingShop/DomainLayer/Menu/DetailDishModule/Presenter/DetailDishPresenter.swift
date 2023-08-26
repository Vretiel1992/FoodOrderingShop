//
//  DetailDishPresenter.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 12.07.2023.
//

import Foundation

protocol DetailDishPresenterProtocol: AnyObject {

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
    private var dish: DishModel {
        didSet {
            view?.update(with: selectedDishMapper.map(dish))
        }
    }
    private let selectedDishMapper = SelectedDishMapper()

    // MARK: - Initializers

    init(
        view: DetailDishViewProtocol,
        router: DetailDishRouterProtocol,
        basketManager: BasketManagerProtocol,
        dish: DishModel
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

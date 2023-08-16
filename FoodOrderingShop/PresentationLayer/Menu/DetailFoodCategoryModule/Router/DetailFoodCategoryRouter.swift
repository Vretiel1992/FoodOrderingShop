//
//  DetailFoodCategoryRouter.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 12.07.2023.
//

import Foundation

protocol DetailFoodCategoryRouterProtocol {
    func popToMain()
    func openDetailDish(_ dish: Dish)
}

final class DetailFoodCategoryRouter: DetailFoodCategoryRouterProtocol {

    // MARK: - Private Properties

    private weak var view: Presentable?
    private let assembly: AssemblyProtocol

    // MARK: - Initializers

    init(view: Presentable, assembly: AssemblyProtocol) {
        self.view = view
        self.assembly = assembly
    }

    // MARK: - Protocol Methods

    func popToMain() {
        view?.navigationController?.popViewController(animated: true)
    }

    func openDetailDish(_ dish: Dish) {
        let presentable = assembly.createDetailDishModule(
            dish: dish
        )

        presentable.modalPresentationStyle = .overFullScreen
        view?.present(presentable, animated: false)
    }
}

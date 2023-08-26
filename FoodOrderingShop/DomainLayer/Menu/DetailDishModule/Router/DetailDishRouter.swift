//
//  DetailDishRouter.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 13.07.2023.
//

import Foundation

protocol DetailDishRouterProtocol {

    func dismiss()
}

final class DetailDishRouter: DetailDishRouterProtocol {

    // MARK: - Private Properties

    private weak var view: Presentable?

    // MARK: - Initializers

    init(view: Presentable) {
        self.view = view
    }

    // MARK: - Protocol Methods

    func dismiss() {
        view?.dismiss(animated: false)
    }
}

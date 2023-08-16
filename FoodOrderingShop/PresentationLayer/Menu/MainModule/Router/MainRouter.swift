//
//  MainRouter.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 07.07.2023.
//

import Foundation

protocol MainRouterProtocol {
    func openDetailFoodCategory(_ category: FoodCategory)
}

final class MainRouter: MainRouterProtocol {

    // MARK: - Private Properties

    private weak var view: Presentable?
    private let assembly: AssemblyProtocol

    // MARK: - Initializers

    init(view: Presentable, assembly: AssemblyProtocol) {
        self.view = view
        self.assembly = assembly
    }

    // MARK: - Protocol Methods

    func openDetailFoodCategory(_ category: FoodCategory) {
        let presentable = assembly.createDetailFoodCategoryModule(
            foodCategory: category
        )

        view?.navigationController?.pushViewController(presentable, animated: true)
    }
}

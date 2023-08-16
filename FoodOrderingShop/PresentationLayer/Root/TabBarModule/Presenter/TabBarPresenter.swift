//
//  TabBarPresenter.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 24.07.2023.
//

import Foundation

protocol TabBarPresenterProtocol: AnyObject {
    init(router: TabBarRouterProtocol)
}

final class TabBarPresenter: TabBarPresenterProtocol {

    // MARK: - Private Properties

    weak var view: TabBarViewProtocol?
    private let router: TabBarRouterProtocol

    // MARK: - Initializers

    required init(router: TabBarRouterProtocol) {
        self.router = router
    }
}

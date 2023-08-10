//
//  TabBarRouter.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 24.07.2023.
//

import Foundation

protocol TabBarRouterProtocol {
    func switchTo(index: Int)
}

class TabBarRouter: TabBarRouterProtocol {

    // MARK: - Private Properties

    weak var view: Presentable?

    // MARK: - Protocol Methods

    func switchTo(index: Int) {
        view?.tabBarController?.selectedIndex = index
    }
}

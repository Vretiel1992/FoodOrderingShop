//
//  TabBarRouter.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 24.07.2023.
//

import Foundation

protocol TabBarRouterProtocol {
    func createMainModule() -> Presentable
    func createSearchModule() -> Presentable
    func createBasketModule() -> Presentable
    func createAccountModule() -> Presentable
    func switchTo(index: Int)
}

class TabBarRouter: TabBarRouterProtocol {

    // MARK: - Private Properties

    private weak var view: Presentable?
    private let assembly: AssemblyProtocol

    // MARK: - Initializers

    init(
        view: Presentable,
        assembly: AssemblyProtocol
    ) {
        self.view = view
        self.assembly = assembly
    }

    // MARK: - Protocol Methods

    func createMainModule() -> Presentable {
        let presentable = assembly.createMainModule()
        return presentable
    }

    func createSearchModule() -> Presentable {
        let presentable = assembly.createSearchModule()
        return presentable
    }

    func createBasketModule() -> Presentable {
        let presentable = assembly.createBasketModule()
        return presentable
    }

    func createAccountModule() -> Presentable {
        let presentable = assembly.createAccountModule()
        return presentable
    }

    func switchTo(index: Int) {
        view?.tabBarController?.selectedIndex = index
    }
}

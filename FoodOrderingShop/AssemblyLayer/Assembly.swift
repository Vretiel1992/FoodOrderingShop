//
//  Assembly.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 03.07.2023.
//

import UIKit

typealias Presentable = UIViewController

protocol AssemblyProtocol {
    func createTabBarModule() -> Presentable
    func createMainModule() -> Presentable
    func createDetailFoodCategoryModule(foodCategory: FoodCategory) -> Presentable
    func createDetailDishModule(dish: Dish) -> Presentable
    func createSearchModule() -> Presentable
    func createBasketModule() -> Presentable
    func createAccountModule() -> Presentable
}

class Assembly: AssemblyProtocol {

    // MARK: - Private Properties

    private let networkManager: NetworkManagerProtocol
    private let locationManager: LocationManagerProtocol
    private let menuAPIManager: MenuAPIManagerProtocol
    private let basketManager: BasketManagerProtocol

    // MARK: - Initializers

    init() {
        self.networkManager = NetworkManager()
        self.locationManager = LocationManager()
        self.menuAPIManager = MenuAPIManager(networkManager: networkManager)
        self.basketManager = BasketManager(networkManager: networkManager)
    }

    // MARK: - Protocol Methods

    func createTabBarModule() -> Presentable {
        let router = TabBarRouter()
        let presenter = TabBarPresenter(router: router)
        let view = TabBarController(
            presenter: presenter,
            tabs: [
                .mainTab(createMainModule),
                .searchTab(createSearchModule),
                .basketTab(createBasketModule),
                .accountTab(createAccountModule)
            ]
        )
        presenter.view = view
        router.view = view
        return view
    }

    func createMainModule() -> Presentable {
        let view = MainViewController()
        let router = MainRouter(
            view: view,
            assembly: self
        )
        let presenter = MainPresenter(
            view: view,
            router: router,
            menuAPIManager: menuAPIManager,
            locationManager: locationManager
        )
        view.presenter = presenter
        return view
    }

    func createDetailFoodCategoryModule(foodCategory: FoodCategory) -> Presentable {
        let view = DetailFoodCategoryViewController()
        let router = DetailFoodCategoryRouter(
            view: view,
            assembly: self
        )
        let presenter = DetailFoodCategoryPresenter(
            view: view,
            menuAPIManager: menuAPIManager,
            router: router,
            foodCategory: foodCategory
        )
        view.presenter = presenter
        return view
    }

    func createDetailDishModule(dish: Dish) -> Presentable {
        let view = DetailDishViewController()
        let router = DetailDishRouter(view: view)
        let presenter = DetailDishPresenter(
            view: view,
            router: router,
            basketManager: basketManager,
            dish: dish
        )
        view.presenter = presenter
        return view
    }

    func createSearchModule() -> Presentable {
        let view = SearchViewController()
        return view
    }

    func createBasketModule() -> Presentable {
        let view = BasketViewController()
        let presenter = BasketPresenter(
            view: view,
            basketManager: basketManager
        )
        view.presenter = presenter
        return view
    }

    func createAccountModule() -> Presentable {
        let view = AccountViewController()
        return view
    }
}

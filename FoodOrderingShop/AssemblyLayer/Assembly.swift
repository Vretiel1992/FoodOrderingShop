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

    func createTabBarModule() -> Presentable {
        let view = TabBarController()
        let router = TabBarRouter(
            view: view,
            assembly: self
        )
        let presenter = TabBarPresenter(
            view: view,
            router: router
        )
        view.presenter = presenter
        return view
    }

    func createMainModule() -> Presentable {
        let view = MainViewController()
        let networkManager = NetworkManager()
        let locationManager = LocationManager()
        let router = MainRouter(
            view: view,
            assembly: self
        )
        let presenter = MainPresenter(
            view: view,
            router: router,
            networkManager: networkManager,
            locationManager: locationManager
        )
        view.presenter = presenter
        return view
    }

    func createDetailFoodCategoryModule(foodCategory: FoodCategory) -> Presentable {
        let view = DetailFoodCategoryViewController()
        let networkManager = NetworkManager()
        let router = DetailFoodCategoryRouter(
            view: view,
            assembly: self
        )
        let presenter = DetailFoodCategoryPresenter(
            view: view,
            networkManager: networkManager,
            router: router,
            foodCategory: foodCategory
        )
        view.presenter = presenter
        return view
    }

    func createDetailDishModule(dish: Dish) -> Presentable {
        let view = DetailDishViewController()
        let networkManager = NetworkManager()
        let router = DetailDishRouter(view: view)
        let presenter = DetailDishPresenter(
            view: view,
            networkManager: networkManager,
            router: router,
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
        return view
    }

    func createAccountModule() -> Presentable {
        let view = AccountViewController()
        return view
    }
}

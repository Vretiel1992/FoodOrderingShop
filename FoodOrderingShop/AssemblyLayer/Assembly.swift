//
//  Assembly.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 03.07.2023.
//

import UIKit

protocol AssemblyProtocol {
//    func createMainTabBarController(router: RouterProtocol) -> UITabBarController
    func createMainModule() -> UIViewController
    func createDetailFoodCategoryModule(foodCategory: FoodCategory) -> UIViewController
}

class Assembly: AssemblyProtocol {
//    func createMainTabBarController(router: RouterProtocol) -> UITabBarController {
//        let mainTabBarController = MainTabBarController(router: router)
//        mainTabBarController.viewControllers = [
//            createMainModule(router: router)
//        ]
//        return mainTabBarController
//    }

    func createMainModule() -> UIViewController {
        let view = MainViewController()
        let networkManager = NetworkManager()
        let locationManager = LocationManager()
        let presenter = MainPresenter(
            view: view,
            networkManager: networkManager,
            locationManager: locationManager
        )
        view.presenter = presenter
        return view
    }

    func createDetailFoodCategoryModule(foodCategory: FoodCategory) -> UIViewController {
        let view = DetailFoodCategoryViewController()
        let networkManager = NetworkManager()
        let presenter = DetailFoodCategoryPresenter(
            view: view,
            networkManager: networkManager,
            foodCategory: foodCategory)
        view.presenter = presenter
        return view
    }
}

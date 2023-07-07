//
//  Assembly.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 03.07.2023.
//

import UIKit

typealias Presentable = UIViewController

typealias MainModule = MainPresenterProtocol

typealias DetailFoodCategoryModule = DetailFoodCategoryPresenterProtocol

protocol AssemblyProtocol {
    func createMainModule() -> Presentable
    func createDetailFoodCategoryModule(foodCategory: FoodCategory) -> Presentable
}

class Assembly: AssemblyProtocol {

    func createMainModule() -> Presentable {
        let view = MainViewController()
        let networkManager = NetworkManager()
        let locationManager = LocationManager()
        let mapper = Mapper()
        let router = MainRouter(view: view, assembly: self)
        let presenter = MainPresenter(
            view: view,
            mapper: mapper,
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
        let mapper = Mapper()
        let presenter = DetailFoodCategoryPresenter(
            view: view,
            networkManager: networkManager,
            mapper: mapper,
            foodCategory: foodCategory)
        view.presenter = presenter
        return view
    }
}

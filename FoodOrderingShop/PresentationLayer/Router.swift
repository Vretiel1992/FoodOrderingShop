//
//  Router.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 05.07.2023.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var mainNavigationController: UINavigationController? { get set }
    var searchNavigationController: UINavigationController? { get set }
    var basketNavigationController: UINavigationController? { get set }
    var accountNavigationController: UINavigationController? { get set }
    var assembly: AssemblyProtocol? { get set }
}

protocol RouterProtocol: RouterMain {
    func initialViewController()
    func showDetailFoodCategory(foodCategory: FoodCategory)
}

class Router: RouterProtocol {

    // MARK: - Public Properties

    var navigationController: UINavigationController?
    var mainNavigationController: UINavigationController?
    var searchNavigationController: UINavigationController?
    var basketNavigationController: UINavigationController?
    var accountNavigationController: UINavigationController?
    var assembly: AssemblyProtocol?

    // MARK: - Initializers

    init(
        navigationController: UINavigationController,
        mainNavigationController: UINavigationController,
        searchNavigationController: UINavigationController,
        basketNavigationController: UINavigationController,
        accountNavigationController: UINavigationController,
        assembly: AssemblyProtocol
    ) {
        self.navigationController = navigationController
        self.mainNavigationController = mainNavigationController
        self.searchNavigationController = searchNavigationController
        self.basketNavigationController = basketNavigationController
        self.accountNavigationController = accountNavigationController
        self.assembly = assembly
    }

    // MARK: - Protocol Methods

    func initialViewController() {
//        guard let mainViewController = mainNavigationController?.viewControllers.first
//        as? MainViewController else { return }
//        mainNavigationController?.popToViewController(mainViewController, animated: true)

//        guard let navigationController = mainNavigationController else { return }
//        guard let mainViewController = assembly?.createMainModule(router: self) else { return }
//        navigationController.viewControllers = [mainViewController]
    }

    func showDetailFoodCategory(foodCategory: FoodCategory) {

    }
}

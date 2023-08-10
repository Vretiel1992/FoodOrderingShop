//
//  TabBarController.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 02.07.2023.
//

import UIKit

typealias Imageable = UIImage

protocol TabBarViewProtocol: AnyObject {
    init(presenter: TabBarPresenterProtocol, tabs: [TabModel])
}

class TabBarController: UITabBarController {

    // MARK: - Private Properties

    var presenter: TabBarPresenterProtocol

    // MARK: - Initializers

    required init(
        presenter: TabBarPresenterProtocol,
        tabs: [TabModel]
    ) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
        configureAppearance(tabs: tabs)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func configureAppearance(tabs: [TabModel]) {
        tabBar.tintColor = Colors.activeTabBarItem.color
        tabBar.barTintColor = Colors.inactiveTabBarItem.color
        tabBar.backgroundColor = .white
        tabBar.layer.borderColor = Colors.borderTabBar.color.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true

        let controllers: [UINavigationController] = tabs.enumerated().map { idx, tab in
            let controller = UINavigationController(
                rootViewController: tab.controllerBuilder()
            )
            controller.tabBarItem = UITabBarItem(
                title: tab.title,
                image: tab.icon,
                tag: idx
            )
            return controller
        }
        setViewControllers(controllers, animated: false)
    }
}

// MARK: - TabBarViewProtocol

extension TabBarController: TabBarViewProtocol {}

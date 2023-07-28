//
//  TabBarController.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 02.07.2023.
//

import UIKit

typealias Imageable = UIImage

protocol TabBarViewProtocol: AnyObject {
    func updateView(with tabs: [Tab])
}

class TabBarController: UITabBarController {

    // MARK: - Private Properties

    var presenter: TabBarPresenterProtocol?

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
        DispatchQueue.main.async { [weak self] in
            self?.presenter?.viewDidLoad()
        }
    }

    // MARK: - Private Methods

    private func configureAppearance() {
        tabBar.tintColor = Colors.activeTabBarItem.color
        tabBar.barTintColor = Colors.inactiveTabBarItem.color
        tabBar.backgroundColor = .white
        tabBar.layer.borderColor = Colors.borderTabBar.color.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true
    }
}

// MARK: - TabBarViewProtocol

extension TabBarController: TabBarViewProtocol {
    func updateView(with tabs: [Tab]) {
        let controllers: [UINavigationController] = tabs.map { tab in
            let controller = UINavigationController(
                rootViewController: presenter?.giveController(for: tab) ?? UIViewController()
            )
            controller.tabBarItem = UITabBarItem(
                title: presenter?.giveTitle(for: tab),
                image: presenter?.giveIcon(for: tab),
                tag: tab.rawValue
            )
            return controller
        }
        setViewControllers(controllers, animated: false)
    }
}

//
//  MainTabBarController.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 02.07.2023.
//

import UIKit

enum Tabs: Int, CaseIterable {
    case main
    case search
    case basket
    case account
}

class MainTabBarController: UITabBarController {

    // MARK: - Private Properties

    private let assembly: AssemblyProtocol
    
    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        configureAppearance()
    }

    // MARK: - Public Methods

    func switchTo(tab: Tabs) {
        selectedIndex = tab.rawValue
    }

    // MARK: - Initializers

    init(assembly: AssemblyProtocol) {
        self.assembly = assembly
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func configureAppearance() {
        tabBar.tintColor = Const.Colors.activeTabBarItem
        tabBar.barTintColor = Const.Colors.inactiveTabBarItem
        tabBar.backgroundColor = .white
        tabBar.layer.borderColor = Const.Colors.borderTabBar.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true

        let controllers: [UINavigationController] = Tabs.allCases.map { tab in
            let controller = UINavigationController(rootViewController: getController(for: tab))
            controller.tabBarItem = UITabBarItem(title: Const.Strings.TabBar.title(for: tab),
                                                 image: Const.Images.TabBar.icon(for: tab),
                                                 tag: tab.rawValue)
            return controller
        }
        setViewControllers(controllers, animated: false)
    }

    private func getController(for tab: Tabs) -> UIViewController {
        switch tab {
        case .main:
            return assembly.createMainModule()
        case .search:
            return SearchViewController()
        case .basket:
            return BasketViewController()
        case .account:
            return AccountViewController()
        }
    }
}

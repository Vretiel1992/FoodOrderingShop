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
        tabBar.tintColor = Colors.activeTabBarItem.color
        tabBar.barTintColor = Colors.inactiveTabBarItem.color
        tabBar.backgroundColor = .white
        tabBar.layer.borderColor = Colors.borderTabBar.color.cgColor
        tabBar.layer.borderWidth = 1
        tabBar.layer.masksToBounds = true

        let controllers: [UINavigationController] = Tabs.allCases.map { tab in
            let controller = UINavigationController(
                rootViewController: getController(for: tab)
            )
            controller.tabBarItem = UITabBarItem(
                title: setTitle(for: tab),
                image: setIcon(for: tab),
                tag: tab.rawValue
            )

            return controller
        }
        setViewControllers(controllers, animated: false)
    }

    private func getController(for tab: Tabs) -> Presentable {
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

    private func setTitle(for tab: Tabs) -> String {
        switch tab {
        case .main:
            return Strings.TabBar.Tabs.main
        case .search:
            return Strings.TabBar.Tabs.search
        case .basket:
            return Strings.TabBar.Tabs.basket
        case .account:
            return Strings.TabBar.Tabs.account
        }
    }

    private func setIcon(for tab: Tabs) -> UIImage? {
        switch tab {
        case .main:
            return Assets.TabBar.mainIcon.image
        case .search:
            return Assets.TabBar.searchIcon.image
        case .basket:
            return Assets.TabBar.basketIcon.image
        case .account:
            return Assets.TabBar.accountIcon.image
        }
    }
}

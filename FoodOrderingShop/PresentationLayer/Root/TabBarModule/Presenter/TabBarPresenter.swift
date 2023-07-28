//
//  TabBarPresenter.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 24.07.2023.
//

import Foundation

enum Tab: Int, CaseIterable {
    case main
    case search
    case basket
    case account
}

protocol TabBarPresenterProtocol: AnyObject {
    init(
        view: TabBarViewProtocol,
        router: TabBarRouterProtocol
    )
    func viewDidLoad()
    func giveController(for tab: Tab) -> Presentable
    func giveTitle(for tab: Tab) -> String
    func giveIcon(for tab: Tab) -> Imageable
}

class TabBarPresenter: TabBarPresenterProtocol {

    // MARK: - Private Properties

    private weak var view: TabBarViewProtocol?
    private let router: TabBarRouterProtocol

    // MARK: - Initializers

    required init(
        view: TabBarViewProtocol,
        router: TabBarRouterProtocol
    ) {
        self.view = view
        self.router = router
    }

    // MARK: - Protocol Methods

    func viewDidLoad() {
        view?.updateView(with: Tab.allCases)
    }

    func giveController(for tab: Tab) -> Presentable {
        switch tab {
        case .main:
            return router.createMainModule()
        case .search:
            return router.createSearchModule()
        case .basket:
            return router.createBasketModule()
        case .account:
            return router.createAccountModule()
        }
    }

    func giveTitle(for tab: Tab) -> String {
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

    func giveIcon(for tab: Tab) -> Imageable {
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

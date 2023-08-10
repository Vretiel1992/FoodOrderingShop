//
//  TabModel.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 28.07.2023.
//

import UIKit

struct TabModel {

    let title: String
    let icon: UIImage
    let controllerBuilder: () -> Presentable
}

extension TabModel {

    static func mainTab(_ builder: @escaping () -> Presentable) -> TabModel {
        TabModel(title: Strings.TabBar.mainTitle, icon: Assets.TabBar.mainIcon.image, controllerBuilder: builder)
    }

    static func searchTab(_ builder: @escaping () -> Presentable) -> TabModel {
        TabModel(title: Strings.TabBar.searchTitle, icon: Assets.TabBar.searchIcon.image, controllerBuilder: builder)
    }

    static func basketTab(_ builder: @escaping () -> Presentable) -> TabModel {
        TabModel(title: Strings.TabBar.basketTitle, icon: Assets.TabBar.basketIcon.image, controllerBuilder: builder)
    }

    static func accountTab(_ builder: @escaping () -> Presentable) -> TabModel {
        TabModel(title: Strings.TabBar.accountTitle, icon: Assets.TabBar.accountIcon.image, controllerBuilder: builder)
    }
}

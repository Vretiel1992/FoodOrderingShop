//
//  Const.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 02.07.2023.
//

import UIKit

enum Const {
    enum Colors {
        static let activeTabBarItem = UIColor(hexString: "#3364E0")
        static let inactiveTabBarItem = UIColor(hexString: "#A5A9B2")
        static let borderTabBar = UIColor(hexString: "#E8E9EC")
        static let backgroundErrorView = UIColor(hexString: "#F8F7F5")
        static let backgroundLoadingView = UIColor(hexString: "#F8F7F5")
        static let backgroundDishView = UIColor(hexString: "#F8F7F5")
        static let activeDishTag = UIColor(hexString: "#3364E0")
        static let inactiveDishTag = UIColor(hexString: "#F8F7F5")
        static let backgroundButton = UIColor(hexString: "#3364E0")
    }

    enum Strings {
        enum TabBar {
            static func title(for tab: Tabs) -> String {
                switch tab {
                case .main:
                    return "Главная"
                case .search:
                    return "Поиск"
                case .basket:
                    return "Корзина"
                case .account:
                    return "Аккаунт"
                }
            }
        }
        static let urlFoodCategories = "https://run.mocky.io/v3/058729bd-1402-4578-88de-265481fd7d54"
        static let urlDishes = "https://run.mocky.io/v3/aba7ecaa-0a70-453b-b62d-0e326c859b3b"
        static let defaultCellIdentifier = "defaultCellIdentifier"
        static let mainCellIdentifier = "mainCellIdentifier"
        static let cityNotDefined = "Город не определен"
        static let locationAlertTitle = "Доступ к геолокации запрещен"
        static let locationAlertMessage = "Для определения вашего местоположения необходимо включить доступ к геолокации в настройках приложения."
        static let settingButton = "Настройки"
        static let cancelButton = "Отмена"
        static let dateFormat = "d MMMM, yyyy"
        static let localIdentifier = "ru_RU"
        static let loadingFoodCategories = "загрузка\nкатегорий блюд"
        static let updateViewButton = "Обновить"
        static let empty = ""
        static let dishTagCellIdentifier = "dishTagCellIdentifier"
        static let dishCellIdentifier = "dishCellIdentifier"
    }

    enum Images {
        enum TabBar {
            static func icon(for tab: Tabs) -> UIImage? {
                switch tab {
                case .main:
                    return UIImage(named: "mainIcon")
                case .search:
                    return UIImage(named: "searchIcon")
                case .basket:
                    return UIImage(named: "basketIcon")
                case .account:
                    return UIImage(named: "accountIcon")
                }
            }
        }
        static let userPhoto = UIImage(named: "userPhoto")
        static let locationIcon = UIImage(named: "locationIcon")
    }
}

// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum Strings {
  internal enum DetailDishModule {
    internal enum DishView {
      internal enum AddToBasketButton {
        /// Добавить в корзину
        internal static let title = Strings.tr("Localizable", "DetailDishModule.DishView.addToBasketButton.title", fallback: "Добавить в корзину")
      }
    }
  }
  internal enum DetailFoodCategoryModule {
    internal enum TopView {
      /// Азиатская кухня
      internal static let title = Strings.tr("Localizable", "DetailFoodCategoryModule.TopView.title", fallback: "Азиатская кухня")
    }
  }
  internal enum MainModule {
    internal enum ErrorView {
      internal enum UpdateViewButton {
        /// Обновить
        internal static let title = Strings.tr("Localizable", "MainModule.ErrorView.updateViewButton.title", fallback: "Обновить")
      }
    }
    internal enum LoadingView {
      internal enum InfoLabel {
        /// загрузка
        /// категорий блюд
        internal static let text = Strings.tr("Localizable", "MainModule.LoadingView.infoLabel.text", fallback: "загрузка\nкатегорий блюд")
      }
    }
    internal enum MainVC {
      internal enum LocationAlert {
        /// Для определения вашего местоположения необходимо включить доступ к геолокации в настройках приложения.
        internal static let message = Strings.tr("Localizable", "MainModule.MainVC.locationAlert.message", fallback: "Для определения вашего местоположения необходимо включить доступ к геолокации в настройках приложения.")
        /// Доступ к геолокации запрещен
        internal static let title = Strings.tr("Localizable", "MainModule.MainVC.locationAlert.title", fallback: "Доступ к геолокации запрещен")
        internal enum CancelButton {
          /// Отмена
          internal static let title = Strings.tr("Localizable", "MainModule.MainVC.locationAlert.cancelButton.title", fallback: "Отмена")
        }
        internal enum SettingButton {
          /// Настройки
          internal static let title = Strings.tr("Localizable", "MainModule.MainVC.locationAlert.settingButton.title", fallback: "Настройки")
        }
      }
    }
    internal enum TopView {
      internal enum LocationLabel {
        /// Город не определен
        internal static let initialText = Strings.tr("Localizable", "MainModule.TopView.locationLabel.initialText", fallback: "Город не определен")
      }
    }
  }
  internal enum MenuModel {
    /// Все меню
    internal static let tagNameAllMenu = Strings.tr("Localizable", "MenuModel.tagNameAllMenu", fallback: "Все меню")
    /// Салаты
    internal static let tagNameSalads = Strings.tr("Localizable", "MenuModel.tagNameSalads", fallback: "Салаты")
    /// С рыбой
    internal static let tagNameWithFish = Strings.tr("Localizable", "MenuModel.tagNameWithFish", fallback: "С рыбой")
    /// С рисом
    internal static let tagNameWithRice = Strings.tr("Localizable", "MenuModel.tagNameWithRice", fallback: "С рисом")
  }
  internal enum TabBar {
    internal enum Tabs {
      /// Аккаунт
      internal static let account = Strings.tr("Localizable", "TabBar.tabs.account", fallback: "Аккаунт")
      /// Корзина
      internal static let basket = Strings.tr("Localizable", "TabBar.tabs.basket", fallback: "Корзина")
      /// Localizable.strings
      ///   FoodOrderingShop
      /// 
      ///   Created by Антон Денисюк on 22.07.2023.
      internal static let main = Strings.tr("Localizable", "TabBar.tabs.main", fallback: "Главная")
      /// Поиск
      internal static let search = Strings.tr("Localizable", "TabBar.tabs.search", fallback: "Поиск")
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type

//
//  SceneDelegate.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 02.07.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
//        let navigationController = UINavigationController()
//        let mainNavigationController = UINavigationController()
//        let searchNavigationController = UINavigationController()
//        let basketNavigationController = UINavigationController()
//        let accountNavigationController = UINavigationController()
        let assembly = Assembly()
//        let router = Router(
//            navigationController: navigationController,
//            mainNavigationController: mainNavigationController,
//            searchNavigationController: searchNavigationController,
//            basketNavigationController: basketNavigationController,
//            accountNavigationController: accountNavigationController,
//            assembly: assembly)
        let tabBarController = MainTabBarController(assembly: assembly)
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
    }
}

//
//  Assembly.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 03.07.2023.
//

import UIKit

protocol AssemblyProtocol {
    func createMainModule() -> UIViewController
}

class Assembly: AssemblyProtocol {
    func createMainModule() -> UIViewController {
        let view = MainViewController()
        let networkManager = NetworkManager()
        let locationManager = LocationManager()
        let presenter = MainPresenter(view: view, networkManager: networkManager, locationManager: locationManager)
        view.presenter = presenter
        return view
    }
}

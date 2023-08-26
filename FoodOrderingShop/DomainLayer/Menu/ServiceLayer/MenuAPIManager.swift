//
//  MenuAPIManager.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 14.08.2023.
//

import Foundation

protocol MenuAPIManagerProtocol {

    func getFoodCategories(_ completion: @escaping (Result<[FoodCategoryEntity], Error>) -> Void)
    func getDishes(_ completion: @escaping (Result<[DishEntity], Error>) -> Void)
}

final class MenuAPIManager: MenuAPIManagerProtocol {

    // MARK: - Private Properties

    private let networkManager: NetworkManagerProtocol

    // MARK: - Initializers

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    // MARK: - Protocol Methods

    func getFoodCategories(_ completion: @escaping (Result<[FoodCategoryEntity], Error>) -> Void) {
        networkManager.loadDataModel(url: url(for: "/v3/058729bd-1402-4578-88de-265481fd7d54")) { (result: Result<FoodCategoriesEntity, Error>) in
            switch result {
            case .success(let foodCategoriesData):
                completion(.success(foodCategoriesData.сategories))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getDishes(_ completion: @escaping (Result<[DishEntity], Error>) -> Void) {
        networkManager.loadDataModel(url: url(for: "/v3/aba7ecaa-0a70-453b-b62d-0e326c859b3b")) { (result: Result<MenuEntity, Error>) in
            switch result {
            case .success(let menuModelData):
                completion(.success(menuModelData.dishes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    // MARK: - Private Methods

    private func url(for path: String) -> URL {
        URL(string: "\(AppConstants.baseURL)\(path)")!
    }
}

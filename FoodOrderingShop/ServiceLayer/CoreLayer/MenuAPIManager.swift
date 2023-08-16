//
//  MenuAPIManager.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 14.08.2023.
//

import Foundation

protocol MenuAPIManagerProtocol {
    init(networkManager: NetworkManagerProtocol)
    func getFoodCategories(_ completion: @escaping (Result<[FoodCategory], Error>) -> Void)
    func getDishes(_ completion: @escaping (Result<[Dish], Error>) -> Void)
}

final class MenuAPIManager: MenuAPIManagerProtocol {

    private let networkManager: NetworkManagerProtocol

    required init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    func getFoodCategories(_ completion: @escaping (Result<[FoodCategory], Error>) -> Void) {
        networkManager.loadDataModel(url: AppConstants.URLS.urlFoodCategories) { (result: Result<FoodCategoriesModel, Error>) in
            switch result {
            case .success(let foodCategoriesData):
                let foodCategories = foodCategoriesData.сategories.map {
                    FoodCategory(
                        id: $0.id,
                        name: $0.name,
                        imageURL: $0.imageURL
                    )
                }
                completion(.success(foodCategories))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func getDishes(_ completion: @escaping (Result<[Dish], Error>) -> Void) {
        networkManager.loadDataModel(url: AppConstants.URLS.urlDishes) { (result: Result<MenuModel, Error>) in
            switch result {
            case .success(let menuModelData):
                let dishes = menuModelData.dishes.map {
                    Dish(id: $0.id,
                         name: $0.name,
                         price: $0.price,
                         weight: $0.weight,
                         description: $0.description,
                         imageURL: $0.imageURL,
                         isFavorite: false,
                         inBasket: false,
                         tags: $0.tegs.map {
                        $0 == TagModel.Teg.allMenu.string
                        ? TagModel(teg: TagModel.Teg.allMenu, isSelected: false)
                        : TagModel(teg: TagModel.Teg.custom($0), isSelected: false)
                    })
                }
                completion(.success(dishes))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

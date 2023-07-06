//
//  DetailFoodCategoryPresenter.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 05.07.2023.
//

import Foundation

protocol DetailFoodCategoryPresenterProtocol: AnyObject {
    init(
        view: DetailFoodCategoryViewProtocol,
        networkManager: NetworkManagerProtocol,
        foodCategory: FoodCategory
    )
    func giveFoodCategoryData() -> FoodCategory
    func giveImageData(url: String, _ completion: @escaping (Data?) -> Void)
}

class DetailFoodCategoryPresenter: DetailFoodCategoryPresenterProtocol {

    // MARK: - Public Properties

    weak var view: DetailFoodCategoryViewProtocol?
    var networkManager: NetworkManagerProtocol?
    let foodCategory: FoodCategory

    // MARK: - Initializers

    required init(
        view: DetailFoodCategoryViewProtocol,
        networkManager: NetworkManagerProtocol,
        foodCategory: FoodCategory) {
        self.view = view
        self.networkManager = networkManager
        self.foodCategory = foodCategory
    }

    // MARK: - Protocol Methods

    func giveFoodCategoryData() -> FoodCategory {
        return foodCategory
    }

    func giveImageData(url: String, _ completion: @escaping (Data?) -> Void) {
        getImage(url: url, completion: completion)
    }

    // MARK: - Private Methods

    private func getImage(url: String, completion: @escaping (Data?) -> Void) {
        networkManager?.loadImageData(urlText: url) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let imageData):
                    completion(imageData)
                case .failure(let error):
                    self.view?.failure(error: error.localizedDescription)
                }
            }
        }
    }
}

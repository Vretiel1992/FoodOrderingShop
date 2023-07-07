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
        mapper: MapperProtocol,
        foodCategory: FoodCategory
    )
    func viewDidLoad()
    func giveImageData(url: URL, _ completion: @escaping (Data?) -> Void)
}

class DetailFoodCategoryPresenter: DetailFoodCategoryPresenterProtocol {

    // MARK: - Public Properties

    weak var view: DetailFoodCategoryViewProtocol?
    var networkManager: NetworkManagerProtocol?
    var mapper: MapperProtocol
    let foodCategory: FoodCategory

    // MARK: - Private Properties

    private var dishes: [Dish] = [] {
        didSet {
            view?.update(
                with: mapper.map(processTegs(dishes)),
                with: mapper.map(dishes)
            )
        }
    }

    // MARK: - Initializers

    required init(
        view: DetailFoodCategoryViewProtocol,
        networkManager: NetworkManagerProtocol,
        mapper: MapperProtocol,
        foodCategory: FoodCategory) {
            self.view = view
            self.networkManager = networkManager
            self.mapper = mapper
            self.foodCategory = foodCategory
        }

    // MARK: - Protocol Methods

    func viewDidLoad() {
        getDishesData()
    }

    func giveImageData(url: URL, _ completion: @escaping (Data?) -> Void) {
        getImage(url: url, completion: completion)
    }

    // MARK: - Private Methods

    private func getDishesData() {
        networkManager?.loadDataModel(url: Const.Strings.urlDishes) { [weak self] (result: Result<MenuModel?, Error>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let dishes):
                    if let data = dishes {
                        self.dishes = data.dishes
                    }
                case .failure(let error):
                    self.view?.failure(error: error.localizedDescription)
                }
            }
        }
    }

    private func getImage(url: URL, completion: @escaping (Data?) -> Void) {
        networkManager?.loadImageData(url: url) { [weak self] result in
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

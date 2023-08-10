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
        router: DetailFoodCategoryRouterProtocol,
        foodCategory: FoodCategory
    )
    func viewDidLoad()
    func giveImageData(url: URL, _ completion: @escaping (Data?) -> Void)
    func didTapBackButton()
    func didTapDishTag(with index: Int)
    func didTapDish(with index: Int)
}

class DetailFoodCategoryPresenter: DetailFoodCategoryPresenterProtocol {

    // MARK: - Private Properties

    private weak var view: DetailFoodCategoryViewProtocol?
    private let networkManager: NetworkManagerProtocol
    private let router: DetailFoodCategoryRouterProtocol
    private let foodCategory: FoodCategory
    private let dishTagMapper = DishTagMapper()
    private let dishMapper = DishMapper()
    private let tagGenerator = TagGenerator()
    private var dishes: [Dish] = [] {
        didSet {
            view?.update(
                dishTags.map(dishTagMapper.map),
                dishes.map(dishMapper.map)
            )
        }
    }

    private var dishTags: [TagModel] = []

    // MARK: - Initializers

    required init(
        view: DetailFoodCategoryViewProtocol,
        networkManager: NetworkManagerProtocol,
        router: DetailFoodCategoryRouterProtocol,
        foodCategory: FoodCategory) {
            self.view = view
            self.networkManager = networkManager
            self.router = router
            self.foodCategory = foodCategory
        }

    // MARK: - Protocol Methods

    func viewDidLoad() {
        getDishesData()
    }

    func giveImageData(url: URL, _ completion: @escaping (Data?) -> Void) {
        getImage(url: url, completion: completion)
    }

    func didTapBackButton() {
        router.popToMain()
    }

    func didTapDishTag(with index: Int) {
        guard index < dishTags.count else { return }
        selectTag(with: index)
        view?.update(
            dishTags.map(dishTagMapper.map),
            dishes.compactMap {
                guard $0.tegs.contains(dishTags[index].teg.string) else {
                    return nil
                }
                return dishMapper.map($0)
            }
        )
    }

    func didTapDish(with index: Int) {
        guard index < dishes.count else { return }
        let dish = dishes[index - 1]
        router.openDetailDish(dish)
    }

    // MARK: - Private Methods

    private func selectTag(with index: Int) {
        dishTags = dishTags.enumerated().map { elementIndex, element in
            TagModel(teg: element.teg, isSelected: elementIndex != index)
        }
    }

    private func getDishesData() {
        networkManager.loadDataModel(url: AppConstants.URLS.urlDishes) { [weak self] (result: Result<MenuModel?, Error>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let dishes):
                    if let data = dishes {
                        self.dishTags = self.tagGenerator.process(data.dishes)
                        self.selectTag(with: 0)
                        self.dishes = data.dishes
                    }
                case .failure(let error):
                    self.view?.failure(error: error.localizedDescription)
                }
            }
        }
    }

    private func getImage(url: URL, completion: @escaping (Data?) -> Void) {
        networkManager.loadImageData(url: url) { [weak self] result in
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

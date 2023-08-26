//
//  DetailFoodCategoryPresenter.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 05.07.2023.
//

import Foundation

protocol DetailFoodCategoryPresenterProtocol: AnyObject {

    func viewDidLoad()
    func didTapBackButton()
    func didTapDishTag(with index: Int)
    func didTapDish(with index: Int)
}

final class DetailFoodCategoryPresenter: DetailFoodCategoryPresenterProtocol {

    // MARK: - Private Properties

    private weak var view: DetailFoodCategoryViewProtocol?
    private let menuAPIManager: MenuAPIManagerProtocol
    private let router: DetailFoodCategoryRouterProtocol
    private let foodCategory: FoodCategoryModel
    private let dishTagMapper = DishTagMapper()

    private let dishMapper = DishMapper()
    private let dishEntityMapper = DishEntityMapper()

    private let tagGenerator = TagGenerator()
    private var dishes: [DishModel] = [] {
        didSet {
            view?.update(
                dishTags.map(dishTagMapper.map),
                dishes.map(dishMapper.map)
            )
        }
    }

    private var dishTags: [TagModel] = []

    // MARK: - Initializers

    init(
        view: DetailFoodCategoryViewProtocol,
        menuAPIManager: MenuAPIManagerProtocol,
        router: DetailFoodCategoryRouterProtocol,
        foodCategory: FoodCategoryModel) {
            self.view = view
            self.menuAPIManager = menuAPIManager
            self.router = router
            self.foodCategory = foodCategory
        }

    // MARK: - Protocol Methods

    func viewDidLoad() {
        getDishesData()
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
                guard $0.tags.contains(dishTags[index]) else {
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
        menuAPIManager.getDishes { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let dishesData):
                    self.dishes = self.dishEntityMapper.map(dishesData)
                    self.dishTags = self.tagGenerator.process(self.dishes)
                    self.selectTag(with: 0)
                case .failure(let error):
                    self.view?.failure(error: error.localizedDescription)
                }
            }
        }
    }
}

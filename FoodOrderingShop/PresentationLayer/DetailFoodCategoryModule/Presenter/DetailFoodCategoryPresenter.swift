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
        router: DetailFoodCategoryRouterProtocol,
        foodCategory: FoodCategory
    )
    func viewDidLoad()
    func giveImageData(url: URL, _ completion: @escaping (Data?) -> Void)
    func didTapBackButton()
    func didTapDishTag(_ indexPath: IndexPath)
    func whichItemToSelect() -> IndexPath
    func didTapDish(_ index: Int)
}

class DetailFoodCategoryPresenter: DetailFoodCategoryPresenterProtocol {

    // MARK: - Public Properties

    weak var view: DetailFoodCategoryViewProtocol?
    var networkManager: NetworkManagerProtocol?
    var mapper: MapperProtocol
    var router: DetailFoodCategoryRouterProtocol?
    let foodCategory: FoodCategory

    // MARK: - Private Properties

    private var dishes: [Dish] = [] {
        didSet {
            view?.update(
                mapper.map(dishTags),
                mapper.map(dishes)
            )
        }
    }

    private var dishTags: [Teg] = []

    private var currentTag: Teg = .allMenu {
        didSet {
            let sectionToUpdate = 1
            view?.update(itemIndexPaths, sectionToUpdate, mapper.map(currentTag, dishes))
        }
    }

    private var itemIndexPaths: (activeItem: IndexPath, currentItem: IndexPath) = (
        activeItem: IndexPath(item: 0, section: 0),
        currentItem: IndexPath(item: 0, section: 0)
    )

    // MARK: - Initializers

    required init(
        view: DetailFoodCategoryViewProtocol,
        networkManager: NetworkManagerProtocol,
        mapper: MapperProtocol,
        router: DetailFoodCategoryRouterProtocol,
        foodCategory: FoodCategory) {
            self.view = view
            self.networkManager = networkManager
            self.mapper = mapper
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
        router?.popToMain()
    }

    func didTapDishTag(_ indexPath: IndexPath) {
        guard indexPath.row < dishTags.count else { return }
        itemIndexPaths.activeItem = itemIndexPaths.currentItem
        itemIndexPaths.currentItem = indexPath
        currentTag = dishTags[indexPath.row]
    }

    func whichItemToSelect() -> IndexPath {
        return itemIndexPaths.currentItem
    }

    func didTapDish(_ index: Int) {
        guard index < dishes.count else { return }
        let dish = dishes[index]
        router?.openDetailDish(dish)
    }

    // MARK: - Private Methods

    private func getDishesData() {
        networkManager?.loadDataModel(url: AppConstants.URLS.urlDishes) { [weak self] (result: Result<MenuModel?, Error>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let dishes):
                    if let data = dishes {
                        self.dishTags = processTegs(data.dishes)
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

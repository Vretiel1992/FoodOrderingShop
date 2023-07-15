//
//  DetailDishPresenter.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 12.07.2023.
//

import Foundation

protocol DetailDishPresenterProtocol: AnyObject {
    init(
        view: DetailDishViewProtocol,
        networkManager: NetworkManagerProtocol,
        mapper: MapperProtocol,
        router: DetailDishRouterProtocol,
        dish: Dish
    )
    func viewDidLoad()
    func giveImageData(url: URL, _ completion: @escaping (Data?) -> Void)
    func didTapAddToBasketButton()
    func didTapFavoritesButton()
    func didTapDismissButton()
}

class DetailDishPresenter: DetailDishPresenterProtocol {

    // MARK: - Public Properties

    weak var view: DetailDishViewProtocol?
    var networkManager: NetworkManagerProtocol?
    var mapper: MapperProtocol
    var router: DetailDishRouterProtocol?
    var dish: Dish

    // MARK: - Initializers

    required init(
        view: DetailDishViewProtocol,
        networkManager: NetworkManagerProtocol,
        mapper: MapperProtocol,
        router: DetailDishRouterProtocol,
        dish: Dish) {
            self.view = view
            self.networkManager = networkManager
            self.mapper = mapper
            self.router = router
            self.dish = dish
        }

    // MARK: - Protocol Methods

    func viewDidLoad() {
        view?.update(with: mapper.convert(dish))
    }

    func giveImageData(url: URL, _ completion: @escaping (Data?) -> Void) {
        getImage(url: url, completion: completion)
    }

    func didTapAddToBasketButton() {

    }

    func didTapFavoritesButton() {

    }

    func didTapDismissButton() {
        router?.dismiss()
    }

    // MARK: - Private Methods

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

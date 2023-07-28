//
//  DetailDishViewController.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 12.07.2023.
//

import UIKit
import SnapKit

protocol DetailDishViewProtocol: AnyObject {
    func update(with selectedDish: DishView.Model)
    func failure(error: String)
}

class DetailDishViewController: UIViewController {

    // MARK: - Public Properties

    var presenter: DetailDishPresenterProtocol?

    // MARK: - Private Properties

    private lazy var dishView: DishView = {
        let view = DishView()
        view.didTapAddToBasketButton = { [weak self] in
            self?.presenter?.didTapAddToBasketButton()
        }
        view.didTapFavoritesButton = { [weak self] in
            self?.presenter?.didTapFavoritesButton()
        }
        view.didTapDismissButton = { [weak self] in
            self?.presenter?.didTapDismissButton()
        }
        return view
    }()

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
        presenter?.viewDidLoad()
    }

    // MARK: - Private Methods

    private func setupViews() {
        view.backgroundColor = .black.withAlphaComponent(0.4)
        view.addSubview(dishView)
    }

    private func setupConstraints() {
        dishView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(view).inset(16)
            make.centerY.equalTo(view)
        }
    }
}

// MARK: - DetailDishViewProtocol

extension DetailDishViewController: DetailDishViewProtocol {
    func update(with selectedDish: DishView.Model) {
        var dish = selectedDish
        if let urlToImage = dish.dishImageURL {
            presenter?.giveImageData(url: urlToImage) { data in
                guard let imageData = data else { return }
                dish.dishImage = UIImage(data: imageData)
                self.dishView.configure(with: dish)
            }
        }

        dishView.configure(with: dish)
    }

    func failure(error: String) {
        print(error)
    }
}

//
//  DishView.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 14.07.2023.
//

import UIKit
import SnapKit

final class DishView: UIView {

    // MARK: - Public Properties

    var didTapAddToBasketButton: (() -> Void)?
    var didTapFavoritesButton: (() -> Void)?
    var didTapDismissButton: (() -> Void)?

    // MARK: - Private Properties

    private let mainBackView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()

    private let backViewDish: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.primaryBackgroundColor.color
        view.layer.cornerRadius = 10
        return view
    }()

    private let vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()

    private let hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fillEqually
        return stackView
    }()

    private let dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let dishNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textAlignment = .left
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 1
        return label
    }()

    private let priceAndWeightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black.withAlphaComponent(0.65)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()

    private lazy var addToBasketButton: UIButton = {
        let button = UIButton()
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.didTapAddToBasketButton?()
        }), for: .touchUpInside)
        return button
    }()

    private lazy var favoriteButton: UIButton = {
        let button = UIButton()
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.didTapFavoritesButton?()
        }), for: .touchUpInside)
        return button
    }()

    private lazy var dismissButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .black
        config.cornerStyle = .medium
        config.image = Assets.DetailDishModule.dismissIcon.image
        config.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 10
        )
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.didTapDismissButton?()
        }), for: .touchUpInside)
        button.configuration = config
        return button
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func setupViews() {
        addSubview(mainBackView)
        addSubview(vStackView)
        vStackView.addArrangedSubview(backViewDish)
        backViewDish.addSubview(dishImageView)
        backViewDish.addSubview(hStackView)
        hStackView.addArrangedSubview(favoriteButton)
        hStackView.addArrangedSubview(dismissButton)
        vStackView.addArrangedSubview(dishNameLabel)
        vStackView.addArrangedSubview(priceAndWeightLabel)
        vStackView.addArrangedSubview(descriptionLabel)
        addSubview(addToBasketButton)
    }

    private func setupConstraints() {
        mainBackView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        vStackView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(mainBackView).inset(16)
            make.bottom.equalTo(addToBasketButton.snp.top).offset(-16)
        }
        addToBasketButton.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalTo(mainBackView).inset(16)
            make.height.equalTo(48)
        }
        backViewDish.snp.makeConstraints { make in
            make.height.equalTo(232)
        }
        dishImageView.snp.makeConstraints { make in
            make.leading.equalTo(backViewDish).inset(57)
            make.trailing.equalTo(backViewDish).inset(56)
            make.top.bottom.equalTo(backViewDish).inset(14)
        }
        hStackView.snp.makeConstraints { make in
            make.top.trailing.equalTo(backViewDish).inset(8)
            make.height.equalTo(40)
            make.width.equalTo(88)
        }
    }

    private func changeFavoriteButtonStyle(isFavorite: Bool) {
        var config = UIButton.Configuration.filled()
        config.baseBackgroundColor = .white
        config.baseForegroundColor = .black
        config.cornerStyle = .medium
        config.image = isFavorite
        ? Assets.DetailDishModule.favoriteIcon.image
        : Assets.DetailDishModule.noFavoriteIcon.image
        config.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 10,
            bottom: 10,
            trailing: 10
        )
        favoriteButton.configuration = config
    }

    private func changeAddToBasketButtonStyle(inBasket: Bool) {
        var config = UIButton.Configuration.filled()
        var title = ""
        if inBasket {
            title = Strings.DetailDishModule.DishView.AddToBasketButton.Title.inBasket
            config.baseBackgroundColor = .black.withAlphaComponent(0.15)
            config.baseForegroundColor = .black
        } else {
            title = Strings.DetailDishModule.DishView.AddToBasketButton.Title.noInBasket
            config.baseBackgroundColor = Colors.secondaryBackgroundColor.color
            config.baseForegroundColor = .white
        }
        config.cornerStyle = .medium
        config.contentInsets = NSDirectionalEdgeInsets(
            top: 15,
            leading: 82,
            bottom: 15,
            trailing: 82
        )
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.92
        let attributeContainer = AttributeContainer([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .medium),
            NSAttributedString.Key.kern: -0.47,
            NSAttributedString.Key.paragraphStyle: paragraphStyle
        ])
        config.attributedTitle = AttributedString(title, attributes: attributeContainer)
        addToBasketButton.configuration = config
    }
}

extension DishView: Configurable {

    struct Model {
        let dishImageURL: URL?
        let dishName: String
        let dishPrice: Int
        let dishWeight: Int
        let dishDescription: String
        var isFavorite: Bool
        var inBasket: Bool
    }

    func configure(with model: Model) {
        if let url = model.dishImageURL {
            dishImageView.setImageURL(url)
        }

        dishNameLabel.setTextAttributes(
            text: model.dishName,
            lineHeightMultiple: 0.88,
            kern: -0.35
        )

        priceAndWeightLabel.attributedText = .dishText(
            price: model.dishPrice,
            weight: model.dishWeight
        )

        descriptionLabel.setTextAttributes(
            text: model.dishDescription,
            lineHeightMultiple: 0.92,
            kern: -0.4
        )

        changeFavoriteButtonStyle(isFavorite: model.isFavorite)
        changeAddToBasketButtonStyle(inBasket: model.inBasket)
    }
}

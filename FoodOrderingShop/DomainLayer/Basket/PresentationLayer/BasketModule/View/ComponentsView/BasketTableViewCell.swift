//
//  BasketTableViewCell.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 16.08.2023.
//

import UIKit
import SnapKit

final class BasketTableViewCell: UITableViewCell {

    // MARK: - Private Properties

    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private let hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .center
        return stackView
    }()

    private let vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()

    private let backViewDish: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.primaryBackgroundColor.color
        view.layer.cornerRadius = 6
        return view
    }()

    private let dishImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let dishNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 2
        return label
    }()

    private let priceAndWeightLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textAlignment = .left
        label.numberOfLines = 1
        return label
    }()

    private let countOfDishesStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.value = 1
        stepper.minimumValue = 1
        stepper.stepValue = 1
        stepper.autorepeat = false
        stepper.wraps = true
        stepper.backgroundColor = Colors.tertiaryBackgroundColor.color
        stepper.layer.cornerRadius = 10
        stepper.clipsToBounds = true
        return stepper
    }()

    // MARK: - Initializers

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Override Methods

    override func prepareForReuse() {
        super.prepareForReuse()
        dishImageView.image = nil
        dishNameLabel.text = nil
        priceAndWeightLabel.text = nil
        countOfDishesStepper.value = 1
    }

    // MARK: - Private Methods

    private func setupViews() {
        selectionStyle = .none
        contentView.backgroundColor = .clear
        contentView.addSubview(separatorView)
        contentView.addSubview(hStackView)
        hStackView.addArrangedSubview(backViewDish)
        backViewDish.addSubview(dishImageView)
        hStackView.addArrangedSubview(vStackView)
        vStackView.addArrangedSubview(dishNameLabel)
        vStackView.addArrangedSubview(priceAndWeightLabel)
        hStackView.addArrangedSubview(countOfDishesStepper)
    }

    private func setupConstraints() {
        separatorView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(contentView)
            make.height.equalTo(16)
        }
        hStackView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom)
            make.leading.trailing.equalTo(contentView).inset(16)
            make.bottom.equalTo(contentView)
        }
        backViewDish.snp.makeConstraints { make in
            make.height.width.equalTo(62)
        }
        dishImageView.snp.makeConstraints { make in
            make.edges.equalTo(backViewDish).inset(8)
        }
    }

}

// MARK: - Configurable

extension BasketTableViewCell: Configurable {

    struct Model {
        let dishImageURL: URL?
        let dishName: String
        let dishPrice: Int
        let dishWeight: Int
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
    }
}

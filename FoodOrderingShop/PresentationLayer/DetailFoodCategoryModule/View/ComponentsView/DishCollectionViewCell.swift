//
//  DishCollectionViewCell.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 06.07.2023.
//

import UIKit
import SnapKit

class DishCollectionViewCell: UICollectionViewCell {

    // MARK: - Private Properties

    private let vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.alignment = .fill
        return stackView
    }()

    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = Const.Colors.backgroundDishView
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
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
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 2
        return label
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

    // MARK: - Override Methods

    override func prepareForReuse() {
        dishImageView.image = nil
        dishNameLabel.text = nil
    }

    // MARK: - Private Methods

    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.addSubview(vStackView)
        vStackView.addArrangedSubview(backView)
        backView.addSubview(dishImageView)
        vStackView.addArrangedSubview(dishNameLabel)
    }

    private func setupConstraints() {
        vStackView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
        }
        backView.snp.makeConstraints { make in
            make.height.equalTo(109)
        }
        dishImageView.snp.makeConstraints { make in
            make.edges.equalTo(backView).inset(15)
        }
    }
}

// MARK: - Configurable

extension DishCollectionViewCell: Configurable {

    struct Model {
        let dishName: String
        var dishImage: UIImage?
        let dishImageURL: URL?
    }

    func configure(with model: Model) {
        dishNameLabel.text = model.dishName

        if let image = model.dishImage {
            dishImageView.image = image
        }
    }
}

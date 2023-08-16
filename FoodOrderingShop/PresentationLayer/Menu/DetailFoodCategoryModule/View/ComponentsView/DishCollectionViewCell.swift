//
//  DishCollectionViewCell.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 06.07.2023.
//

import UIKit
import SnapKit

final class DishCollectionViewCell: UICollectionViewCell {

    // MARK: - Private Properties

    private let vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        return stackView
    }()

    private let backView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.primaryBackgroundColor.color
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
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textAlignment = .left
        label.lineBreakMode = .byWordWrapping
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
        super.prepareForReuse()
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
        let id: Int
        let dishName: String
        let dishImageURL: URL?
    }

    func configure(with model: Model) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.88
        let attributes: [NSAttributedString.Key: Any] = [
            .kern: -0.4,
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: model.dishName, attributes: attributes)
        dishNameLabel.attributedText = attributedString

        if let url = model.dishImageURL {
            dishImageView.setImageURL(url)
        }
    }
}

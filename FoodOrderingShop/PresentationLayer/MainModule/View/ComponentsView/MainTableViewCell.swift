//
//  MainTableViewCell.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 03.07.2023.
//

import UIKit
import SnapKit

protocol Configurable {
    associatedtype Model

    func configure(with model: Model)
}

class MainTableViewCell: UITableViewCell {

    // MARK: - Private Properties

    private let separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    private let foodCategoryImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()

    private let foodCategoryNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 2
        label.backgroundColor = .clear
        label.lineBreakMode = .byTruncatingHead
        return label
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
        foodCategoryImageView.image = nil
        foodCategoryNameLabel.text = nil
    }

    // MARK: - Private Methods

    private func setupViews() {
        selectionStyle = .none
        contentView.backgroundColor = .white
        contentView.addSubview(separatorView)
        contentView.addSubview(foodCategoryImageView)
        foodCategoryImageView.addSubview(foodCategoryNameLabel)
    }

    private func setupConstraints() {
        separatorView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(contentView)
            make.height.equalTo(8)
        }
        foodCategoryImageView.snp.makeConstraints { make in
            make.top.equalTo(separatorView.snp.bottom)
            make.leading.trailing.equalTo(contentView).inset(16)
            make.bottom.equalTo(contentView)
        }
        foodCategoryNameLabel.snp.makeConstraints { make in
            make.top.equalTo(foodCategoryImageView).inset(12)
            make.leading.equalTo(foodCategoryImageView).inset(16)
            make.width.equalTo(foodCategoryImageView.snp.width).multipliedBy(0.5)
        }
    }
}

// MARK: - Configurable

extension MainTableViewCell: Configurable {

    struct Model {
        let foodCategoryName: String
        var foodCategoryImage: UIImage?
        let foodCategoryImageURL: URL?
    }

    func configure(with model: Model) {
        foodCategoryNameLabel.text = model.foodCategoryName

        if let image =  model.foodCategoryImage {
            foodCategoryImageView.image = image
        }
    }
}

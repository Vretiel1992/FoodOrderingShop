//
//  TopDetailFoodCategoryView.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 09.07.2023.
//

import UIKit
import SnapKit

class TopDetailFoodCategoryView: UIView {

    // MARK: - Public Properties

    var didTapBackButton: (() -> Void)?

    // MARK: - Types

    enum Constants {
        static let titleLabelText = "Азиатская кухня"
        static let backButtonImage = UIImage(named: "backIcon")
    }

    // MARK: - Private Properties

    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Const.Images.userPhoto
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.setTextAttributes(
            text: Constants.titleLabelText,
            lineHeightMultiple: 1.01,
            kern: -0.4
        )
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()

    private lazy var backButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .black
        config.image = Constants.backButtonImage
        config.contentInsets = NSDirectionalEdgeInsets(
            top: 15,
            leading: 18,
            bottom: 15,
            trailing: 18
        )
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.didTapBackButton?()
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

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods

    private func setupViews() {
        addSubview(backButton)
        addSubview(titleLabel)
        addSubview(userPhotoImageView)
    }

    private func setupConstraints() {
        backButton.snp.makeConstraints { make in
            make.top.equalTo(self).inset(8)
            make.leading.equalTo(self).inset(10)
            make.height.width.equalTo(44)
        }
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self).inset(19)
            make.leading.equalTo(backButton.snp.trailing).offset(25)
            make.trailing.equalTo(userPhotoImageView.snp.leading).offset(-13)
        }
        userPhotoImageView.snp.makeConstraints { make in
            make.top.equalTo(self).inset(7)
            make.trailing.equalTo(self).inset(16)
            make.width.height.equalTo(44)
        }
    }
}

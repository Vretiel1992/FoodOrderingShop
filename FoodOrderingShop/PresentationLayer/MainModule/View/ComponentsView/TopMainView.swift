//
//  TopMainView.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 02.07.2023.
//

import UIKit
import CoreLocation
import SnapKit

class TopMainView: UIView {

    // MARK: - Private Properties

    private let vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
        return stackView
    }()

    private let userPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Const.Images.userPhoto
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let locationIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Const.Images.locationIcon
        imageView.contentMode = .top
        return imageView
    }()

    private let locationLabel: UILabel = {
        let label = UILabel()
        label.setTextAttributes(
            text: Const.Strings.cityNotDefined,
            lineHeightMultiple: 1.01,
            kern: -0.4
        )
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 1
        return label
    }()

    private lazy var currentDateLabel: UILabel = {
        let label = UILabel()
        let text = getCurrentDate()
        label.setTextAttributes(
            text: text,
            lineHeightMultiple: 0.96,
            kern: -0.4
        )
        label.textAlignment = .left
        label.textColor = .black.withAlphaComponent(0.5)
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 1
        return label
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

    // MARK: - Public Methods

    func updateLocationLabel(text: String) {
        locationLabel.text = text
    }

    // MARK: - Private Methods

    private func setupViews() {
        addSubview(locationIconImageView)
        addSubview(userPhotoImageView)
        addSubview(vStackView)
        vStackView.addArrangedSubview(locationLabel)
        vStackView.addArrangedSubview(currentDateLabel)

    }

    private func setupConstraints() {
        locationIconImageView.snp.makeConstraints { make in
            make.top.equalTo(self).inset(10)
            make.leading.equalTo(self).inset(16)
            make.height.width.equalTo(24)
        }
        vStackView.snp.makeConstraints { make in
            make.top.equalTo(self).inset(8)
            make.leading.equalTo(locationIconImageView.snp.trailing).offset(4)
            make.height.equalTo(42)
        }
        userPhotoImageView.snp.makeConstraints { make in
            make.top.equalTo(self).inset(7)
            make.trailing.equalTo(self).inset(16)
            make.width.height.equalTo(44)
        }
    }

    private func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Const.Strings.dateFormat
        dateFormatter.locale = Locale(identifier: Const.Strings.localIdentifier)
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        return formattedDate
    }
}

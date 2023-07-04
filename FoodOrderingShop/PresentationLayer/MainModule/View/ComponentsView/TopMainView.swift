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

    private let hStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 4
        return stackView
    }()

    private let vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.distribution = .fillEqually
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
        label.text = Const.Strings.cityNotDefined
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 1
        return label
    }()

    private lazy var currentDateLabel: UILabel = {
        let label = UILabel()
        label.text = getCurrentDate()
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
        addSubview(hStackView)
        hStackView.addArrangedSubview(locationIconImageView)
        hStackView.addArrangedSubview(vStackView)
        hStackView.addArrangedSubview(userPhotoImageView)
        vStackView.addArrangedSubview(locationLabel)
        vStackView.addArrangedSubview(currentDateLabel)
    }

    private func setupConstraints() {
        hStackView.snp.makeConstraints { make in
            make.edges.equalTo(self).inset(
                UIEdgeInsets(top: 6, left: 16, bottom: 6, right: 16)
            )
        }
        userPhotoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(44)
        }
    }

    private func getCurrentDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Const.Strings.dateFormat
        let currentDate = Date()
        let formattedDate = dateFormatter.string(from: currentDate)
        return formattedDate
    }
}

//
//  LoadingView.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 05.07.2023.
//

import UIKit

class LoadingView: UIView {

    // MARK: - Private Properties

    private let vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        return stackView
    }()

    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView()
        indicator.style = .large
        return indicator
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = Const.Strings.loadingFoodCategories
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        label.numberOfLines = 2
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

    func show() {
        isHidden.toggle()
        activityIndicator.startAnimating()
    }

    func hide() {
        isHidden.toggle()
        activityIndicator.stopAnimating()
    }

    // MARK: - Private Methods

    private func setupViews() {
        backgroundColor = Const.Colors.backgroundLoadingView
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray4.cgColor
        isHidden = true
        addSubview(vStackView)
        vStackView.addArrangedSubview(activityIndicator)
        vStackView.addArrangedSubview(infoLabel)
    }

    private func setupConstraints() {
        vStackView.snp.makeConstraints { make in
            make.edges.equalTo(self).inset(15)
        }
    }
}

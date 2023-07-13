//
//  ErrorView.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 04.07.2023.
//

import UIKit
import SnapKit

class ErrorView: UIView {

    // MARK: - Public Properties

    var didTapUpdateViewButton: (() -> Void)?

    // MARK: - Private Properties

    private let vStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .fill
        return stackView
    }()

    private lazy var updateViewButton: UIButton = {
        let button = UIButton()
        var config = UIButton.Configuration.filled()
        let title = Const.Strings.updateViewButton
        config.baseBackgroundColor = Const.Colors.backgroundButton
        config.baseForegroundColor = .white
        config.cornerStyle = .medium
        let attributeContainer = AttributeContainer([
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .medium)
        ])
        config.attributedTitle = AttributedString(title, attributes: attributeContainer)
        button.addAction(UIAction(handler: { [weak self] _ in
            self?.didTapUpdateViewButton?()
        }), for: .touchUpInside)
        button.configuration = config
        return button
    }()

    private let errorTextLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.numberOfLines = 0
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

    func updateErrorTextLabel(text: String) {
        errorTextLabel.text = text
    }

    // MARK: - Private Methods

    private func setupViews() {
        backgroundColor = Const.Colors.backgroundErrorView
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray4.cgColor
        isHidden = true
        addSubview(vStackView)
        vStackView.addArrangedSubview(errorTextLabel)
        vStackView.addArrangedSubview(updateViewButton)
    }

    private func setupConstraints() {
        vStackView.snp.makeConstraints { make in
            make.edges.equalTo(self).inset(15)
        }
        updateViewButton.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
    }
}

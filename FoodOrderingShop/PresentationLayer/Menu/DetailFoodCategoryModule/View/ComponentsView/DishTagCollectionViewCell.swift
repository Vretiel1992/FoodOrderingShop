//
//  DishTagCollectionViewCell.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 06.07.2023.
//

import UIKit
import SnapKit

class DishTagCollectionViewCell: UICollectionViewCell {

    enum SelectionState {
        case selected
        case notSelected
    }

    // MARK: - Public Properties

    var currentSelectionState: SelectionState = .notSelected

    // MARK: - Private Properties

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 1
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
        setSelection(.notSelected)
    }

    // MARK: - Public Methods

    func toggleSelection() {
        switch currentSelectionState {
        case .selected:
            setSelection(.notSelected)
        case .notSelected:
            setSelection(.selected)
        }
    }

    func setSelection(_ state: SelectionState) {
        switch state {
        case .selected:
            contentView.backgroundColor = Colors.activeDishTag.color
            titleLabel.textColor = .white
            currentSelectionState = .selected
        case .notSelected:
            contentView.backgroundColor = Colors.inactiveDishTag.color
            titleLabel.textColor = .black
            currentSelectionState = .notSelected
        }
    }

    // MARK: - Private Methods

    private func setupViews() {
        layer.cornerRadius = 10
        clipsToBounds = true
        contentView.backgroundColor = Colors.inactiveDishTag.color
        contentView.addSubview(titleLabel)
    }

    private func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.edges.equalTo(contentView).inset(
                UIEdgeInsets(top: 10, left: 16, bottom: 10, right: 16)
            )
        }
    }
}

// MARK: - Configurable

extension DishTagCollectionViewCell: Configurable {

    struct Model {
        let dishTagName: String
        var selected: Bool
    }

    func configure(with model: Model) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = 0.88
        let attributes: [NSAttributedString.Key: Any] = [
            .kern: -0.4,
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: model.dishTagName, attributes: attributes)
        titleLabel.attributedText = attributedString
    }
}

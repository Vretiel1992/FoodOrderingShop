//
//  UIButton+.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 14.07.2023.
//

import UIKit

extension UIButton {
    func customize(
        config: UIButton.Configuration,
        title: String? = nil,
        baseBackgroundColor: UIColor,
        baseForegroundColor: UIColor,
        cornerStyle: UIButton.Configuration.CornerStyle,
        contentInsets: NSDirectionalEdgeInsets,
        lineHeightMultiple: CGFloat? = nil,
        font: UIFont? = nil,
        kern: CGFloat? = nil
    ) {
        var config = config
        config.baseBackgroundColor = baseBackgroundColor
        config.baseForegroundColor = baseForegroundColor
        config.cornerStyle = cornerStyle
        config.contentInsets = contentInsets
        if let title = title {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = lineHeightMultiple ?? 1
            let attributeContainer = AttributeContainer([
                NSAttributedString.Key.font: font ?? UIFont.systemFont(ofSize: 17),
                NSAttributedString.Key.kern: kern ?? 0,
                NSAttributedString.Key.paragraphStyle: paragraphStyle
            ])
            config.attributedTitle = AttributedString(title, attributes: attributeContainer)
        }
        self.configuration = config
    }
}

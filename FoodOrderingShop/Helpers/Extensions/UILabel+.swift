//
//  UILabel+.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 09.07.2023.
//

import UIKit

extension UILabel {
    func setTextAttributes(text: String, lineHeightMultiple: CGFloat, kern: CGFloat) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        let attributes: [NSAttributedString.Key: Any] = [
            .kern: kern,
            .paragraphStyle: paragraphStyle
        ]
        let attributedString = NSAttributedString(string: text, attributes: attributes)
        attributedText = attributedString
    }
}

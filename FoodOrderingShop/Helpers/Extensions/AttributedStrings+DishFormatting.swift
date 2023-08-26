import UIKit

extension NSAttributedString {

    static func dishText(price: Int, weight: Int) -> NSAttributedString {
        let priceText = String(price) + " ₽"
        let weightText = " · " + String(weight) + "г"

        let priceTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .kern: -0.4,
            .paragraphStyle: createParagraphStyle()
        ]
        let priceAttributedString = NSAttributedString(string: priceText, attributes: priceTextAttributes)

        let weightTextAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black.withAlphaComponent(0.4),
            .kern: -0.4,
            .paragraphStyle: createParagraphStyle()
        ]
        let weightAttributedString = NSAttributedString(string: weightText, attributes: weightTextAttributes)

        func createParagraphStyle() -> NSMutableParagraphStyle {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineHeightMultiple = 0.88
            return paragraphStyle
        }

        let combinedAttributedString = NSMutableAttributedString()
        combinedAttributedString.append(priceAttributedString)
        combinedAttributedString.append(weightAttributedString)
        return combinedAttributedString
    }
}

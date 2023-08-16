//
//  UIImageView+.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 14.08.2023.
//

import UIKit

extension UIImageView {

//    private func loadImage(_ url: URL, placeholder: UIImage? = nil, completion: @escaping (UIImage?) -> Void) {
//        DispatchQueue.global(qos: .userInitiated).async {
//            guard let data = try? Data(contentsOf: url) else {
//                completion(placeholder)
//                return
//            }
//
//            completion(UIImage(data: data))
//        }
//    }

    private func loadImage(_ url: URL, placeholder: UIImage? = nil, _ completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data, let image = UIImage(data: data) else {
                completion(placeholder)
                return
            }
            completion(image)
        }.resume()
    }

    func setImageURL(_ url: URL, placeholder: UIImage? = nil) {
        tag = url.hashValue
        loadImage(url, placeholder: placeholder) { [weak self] image in
            guard let self = self else { return }

//            guard self.tag == url.hashValue else { return }

            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}

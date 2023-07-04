//
//  NetworkManager.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 02.07.2023.
//

import Foundation

protocol NetworkManagerProtocol {
    func loadDataOfFoodCategories(completion: @escaping (Result<FoodCategories?, Error>) -> Void)
    func loadImageData(urlText: String, completion: @escaping (Result<Data, Error>) -> Void)
}

class NetworkManager: NetworkManagerProtocol {

    enum FetchError: LocalizedError {
        case noInternetConnection
        case decode
        case unknown

        var errorDescription: String? {
            switch self {
            case .noInternetConnection:
                return "Отсутствует подключение к интернету"
            case .decode:
                return "Ошибка декодирования данных"
            case .unknown:
                return "Неизвестная ошибка"
            }
        }
    }

    // MARK: - Protocol Methods

    func loadDataOfFoodCategories(completion: @escaping (Result<FoodCategories?, Error>) -> Void) {
        guard let url = URL(string: Const.Strings.urlFoodCategories) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                error.isNoInternetConnection
                ? completion(.failure(FetchError.noInternetConnection))
                : completion(.failure(FetchError.unknown))
                return
            }
            guard let data = data else {
                completion(.failure(FetchError.unknown))
                return
            }
            do {
                let dataOfFoodCategories = try JSONDecoder().decode(FoodCategories?.self, from: data)
                completion(.success(dataOfFoodCategories))
            } catch {
                completion(.failure(FetchError.unknown))
            }
        }
        task.resume()
    }

    func loadImageData(urlText: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: urlText) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                error.isNoInternetConnection
                ? completion(.failure(FetchError.noInternetConnection))
                : completion(.failure(FetchError.unknown))
                return
            }
            guard let imageData = data else {
                completion(.failure(FetchError.unknown))
                return
            }
            completion(.success(imageData))
        }
        task.resume()
    }
}
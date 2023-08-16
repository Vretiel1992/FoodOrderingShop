//
//  NetworkManager.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 02.07.2023.
//

import Foundation

protocol NetworkManagerProtocol {

    func loadDataModel<T: Codable>(url: URL, _ completion: @escaping (Result<T, Error>) -> Void)
}

final class NetworkManager: NetworkManagerProtocol {

    enum FetchError: LocalizedError {
        case noInternetConnection
        case decode
        case unknown

        var errorDescription: String? {
            switch self {
            case .noInternetConnection:
                return Strings.NetworkManager.Errors.noInternetConnection
            case .decode:
                return Strings.NetworkManager.Errors.decode
            case .unknown:
                return Strings.NetworkManager.Errors.unknown
            }
        }
    }

    // MARK: - Protocol Methods

    func loadDataModel<T: Codable>(url: URL, _ completion: @escaping (Result<T, Error>) -> Void) {
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                if error.isNoInternetConnection {
                    completion(.failure(FetchError.noInternetConnection))
                } else {
                    completion(.failure(FetchError.unknown))
                }
                return
            }
            guard let data = data else {
                completion(.failure(FetchError.unknown))
                return
            }
            do {
                let modelData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(modelData))
            } catch {
                completion(.failure(FetchError.unknown))
            }
        }
        task.resume()
    }
}

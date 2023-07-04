//
//  MainPresenter.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 02.07.2023.
//

import Foundation

protocol MainPresenterProtocol: AnyObject {
    init(
        view: MainViewProtocol,
        networkManager: NetworkManagerProtocol,
        locationManager: LocationManagerProtocol
    )
    func viewDidLoad()
    func giveImageData(url: String, completion: @escaping (Data?) -> Void)
}

class MainPresenter: MainPresenterProtocol {

    // MARK: - Public Properties

    weak var view: MainViewProtocol?
    var networkManager: NetworkManagerProtocol?
    var locationManager: LocationManagerProtocol?

    // MARK: - Private Properties

    private var foodCategories: [FoodСategory] = []

    // MARK: - Initializers

    required init(view: MainViewProtocol, networkManager: NetworkManagerProtocol, locationManager: LocationManagerProtocol) {
        self.view = view
        self.networkManager = networkManager
        self.locationManager = locationManager
    }

    // MARK: - Protocol Methods

    func viewDidLoad() {
        getDataOfFoodCategories()
        checkLocationAuthorization()
        updateLocationLabel()
    }

    func giveImageData(url: String, completion: @escaping (Data?) -> Void) {
        getImage(url: url, completion: completion)
    }

    // MARK: - Private Methods

    private func getDataOfFoodCategories() {
        networkManager?.loadDataOfFoodCategories() { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let dataOfFoodCategories):
                    if let data = dataOfFoodCategories {
                        self.foodCategories = data.сategories
                        self.view?.success(dataOfFoodCategories: self.foodCategories)
                    }
                case .failure(let error):
                    self.view?.failure(error: error.localizedDescription)
                }
            }
        }
    }

    private func getImage(url: String, completion: @escaping (Data?) -> Void) {
        networkManager?.loadImageData(urlText: url) { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let imageData):
                    completion(imageData)
                case .failure(let error):
                    self.view?.failure(error: error.localizedDescription)
                }
            }
        }
    }
    
    private func checkLocationAuthorization() {
        locationManager?.setAuthorizationStatusHandler { [weak self] authorizationStatus in
            guard let self = self else { return }
            switch authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                DispatchQueue.main.async {
                    self.locationManager?.requestLocation()
                }
            case .denied, .restricted:
                self.view?.showLocationAccessDeniedAlert()
            case .notDetermined:
                self.locationManager?.requestWhenInUseAuthorization()
            @unknown default:
                break
            }
        }
        locationManager?.requestWhenInUseAuthorization()
    }

    private func updateLocationLabel() {
        locationManager?.updatingLocation { [weak self] currentLocation, geocoder in
            geocoder.reverseGeocodeLocation(currentLocation) { placemarks, error in
                if let error = error {
                    print("Ошибка геокодирования: \(error.localizedDescription)")
                    return
                }
                guard let placemark = placemarks?.first,
                      let city = placemark.locality else { return }
                DispatchQueue.main.async {
                    self?.view?.updateLocationLabel(text: city)
                }
            }
        }
    }
}

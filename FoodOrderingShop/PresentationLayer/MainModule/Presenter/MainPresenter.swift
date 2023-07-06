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
//        router: RouterProtocol,
        networkManager: NetworkManagerProtocol,
        locationManager: LocationManagerProtocol
    )
    func viewDidLoad()
    func giveFoodCategoriesData() -> [FoodCategory]
    func giveImageData(url: String, _ completion: @escaping (Data?) -> Void)
    func didTapFoodCategory(index: Int)
}

class MainPresenter: MainPresenterProtocol {

    // MARK: - Public Properties

    weak var view: MainViewProtocol?
//    var router: RouterProtocol?
    var networkManager: NetworkManagerProtocol?
    var locationManager: LocationManagerProtocol?

    // MARK: - Private Properties

    private var foodCategories: [FoodCategory] = []

    // MARK: - Initializers

    required init(
        view: MainViewProtocol,
//        router: RouterProtocol,
        networkManager: NetworkManagerProtocol,
        locationManager: LocationManagerProtocol
    ) {
        self.view = view
//        self.router = router
        self.networkManager = networkManager
        self.locationManager = locationManager
    }

    // MARK: - Protocol Methods

    func viewDidLoad() {
        fetchData { [weak self] in
            DispatchQueue.main.async {
                self?.view?.update()
            }
        }
        checkLocationAuthorization()
        updateLocationLabel()
    }

    func giveFoodCategoriesData() -> [FoodCategory] {
        returnFoodCategoriesData()
    }

    func giveImageData(url: String, _ completion: @escaping (Data?) -> Void) {
        getImage(url: url, completion: completion)
    }

    func didTapFoodCategory(index: Int) {
        let foodCategory = foodCategories[index]
//        router?.showDetailFoodCategory(foodCategory)
    }

    // MARK: - Private Methods
    private func fetchData(_ completion: @escaping () -> Void) {
        let group = DispatchGroup()
        group.enter()
        getFoodCategoriesData {
            group.leave()
        }
        group.enter()
        getDishesData {
            group.leave()
        }
        group.notify(queue: .main) {
            completion()
        }
    }

    private func getFoodCategoriesData(_ completion: @escaping () -> Void) {
        networkManager?.loadDataModel(
            url: Const.Strings.urlFoodCategories
        ) { [weak self] (result: Result<FoodCategoriesModel?, Error>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let dataOfFoodCategories):
                    if let data = dataOfFoodCategories {
                        self.foodCategories = data.сategories
                    }
                case .failure(let error):
                    self.view?.failure(error: error.localizedDescription)
                }
            }
            completion()
        }
    }

    private func getDishesData(_ completion: @escaping () -> Void) {
        networkManager?.loadDataModel(url: Const.Strings.urlDishes) { [weak self] (result: Result<MenuModel?, Error>) in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let dishes):
                    if let data = dishes {
                        for index in self.foodCategories.indices {
                            self.foodCategories[index].dishes = data.dishes
                        }
                    }
                case .failure(let error):
                    self.view?.failure(error: error.localizedDescription)
                }
                completion()
            }
        }
    }

    private func returnFoodCategoriesData() -> [FoodCategory] {
        return foodCategories
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

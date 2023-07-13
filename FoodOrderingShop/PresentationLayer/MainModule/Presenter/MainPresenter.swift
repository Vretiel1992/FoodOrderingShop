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
        mapper: MapperProtocol,
        router: MainRouterProtocol,
        networkManager: NetworkManagerProtocol,
        locationManager: LocationManagerProtocol
    )
    func viewDidLoad()
    func giveImageData(url: URL, _ completion: @escaping (Data?) -> Void)
    func didTapFoodCategory(index: Int)
    func didTapUpdateViewButton()
}

class MainPresenter: MainPresenterProtocol {

    // MARK: - Public Properties

    weak var view: MainViewProtocol?
    var networkManager: NetworkManagerProtocol?
    var locationManager: LocationManagerProtocol?
    var mapper: MapperProtocol

    // MARK: - Private Properties

    private var router: MainRouterProtocol?

    private var foodCategories: [FoodCategory] = [] {
        didSet {
            view?.update(with: mapper.map(foodCategories))
        }
    }

    // MARK: - Initializers

    required init(
        view: MainViewProtocol,
        mapper: MapperProtocol,
        router: MainRouterProtocol,
        networkManager: NetworkManagerProtocol,
        locationManager: LocationManagerProtocol
    ) {
        self.view = view
        self.router = router
        self.mapper = mapper
        self.networkManager = networkManager
        self.locationManager = locationManager
    }

    // MARK: - Protocol Methods

    func viewDidLoad() {
        getFoodCategoriesData()
        checkLocationAuthorization()
        updateLocationLabel()
    }

    func giveImageData(url: URL, _ completion: @escaping (Data?) -> Void) {
        getImage(url: url, completion: completion)
    }

    func didTapFoodCategory(index: Int) {
        guard index < foodCategories.count else { return }
        let foodCategory = foodCategories[index]
        router?.openDetailFoodCategory(foodCategory)
    }

    func didTapUpdateViewButton() {
        viewDidLoad()
    }

    // MARK: - Private Methods

    private func getFoodCategoriesData() {
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
        }
    }

    private func getImage(url: URL, completion: @escaping (Data?) -> Void) {
        networkManager?.loadImageData(url: url) { [weak self] result in
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

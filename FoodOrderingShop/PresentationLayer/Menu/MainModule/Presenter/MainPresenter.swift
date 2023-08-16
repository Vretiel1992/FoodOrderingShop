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
        router: MainRouterProtocol,
        menuAPIManager: MenuAPIManagerProtocol,
        locationManager: LocationManagerProtocol
    )
    func viewDidLoad()
    func didTapFoodCategory(index: Int)
    func didTapUpdateViewButton()
}

class MainPresenter: MainPresenterProtocol {

    // MARK: - Private Properties

    private weak var view: MainViewProtocol?
    private let menuAPIManager: MenuAPIManagerProtocol
    private let locationManager: LocationManagerProtocol
    private let router: MainRouterProtocol
    private let foodCategoryMapper = FoodCategoryMapper()

    private var foodCategories: [FoodCategory] = [] {
        didSet {
            view?.update(with: foodCategories.map(foodCategoryMapper.map))
        }
    }

    // MARK: - Initializers

    required init(
        view: MainViewProtocol,
        router: MainRouterProtocol,
        menuAPIManager: MenuAPIManagerProtocol,
        locationManager: LocationManagerProtocol
    ) {
        self.view = view
        self.router = router
        self.menuAPIManager = menuAPIManager
        self.locationManager = locationManager
    }

    // MARK: - Protocol Methods

    func viewDidLoad() {
        getFoodCategoriesData()
        checkLocationAuthorization()
        updateLocationLabel()
    }

    func didTapFoodCategory(index: Int) {
        guard index < foodCategories.count else { return }
        let foodCategory = foodCategories[index]
        router.openDetailFoodCategory(foodCategory)
    }

    func didTapUpdateViewButton() {
        viewDidLoad()
    }

    // MARK: - Private Methods

    private func getFoodCategoriesData() {
        menuAPIManager.getFoodCategories { [weak self] result in
            guard let self = self else { return }
            DispatchQueue.main.async {
                switch result {
                case .success(let foodCategoriesData):
                    self.foodCategories = foodCategoriesData
                case .failure(let error):
                    self.view?.failure(error: error.localizedDescription)
                }
            }
        }
    }

    private func checkLocationAuthorization() {
        locationManager.setAuthorizationStatusHandler { [weak self] authorizationStatus in
            guard let self = self else { return }
            switch authorizationStatus {
            case .authorizedWhenInUse, .authorizedAlways:
                DispatchQueue.main.async {
                    self.locationManager.requestLocation()
                }
            case .denied, .restricted:
                self.view?.showLocationAccessDeniedAlert()
            case .notDetermined:
                self.locationManager.requestWhenInUseAuthorization()
            @unknown default:
                break
            }
        }
        locationManager.requestWhenInUseAuthorization()
    }

    private func updateLocationLabel() {
        locationManager.updatingLocation { [weak self] currentLocation, geocoder in
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

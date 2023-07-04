//
//  LocationManager.swift
//  FoodOrderingShop
//
//  Created by Антон Денисюк on 03.07.2023.
//

import CoreLocation

protocol LocationManagerProtocol {

    func updatingLocation(_ handler: ((CLLocation, CLGeocoder) -> Void)?)
    func setAuthorizationStatusHandler(_ handler: ((CLAuthorizationStatus) -> Void)?)
    func requestLocation()
    func requestWhenInUseAuthorization()
}

class LocationManager: NSObject, LocationManagerProtocol {

    typealias LocationUpdateHandler = (CLLocation, CLGeocoder) -> Void
    typealias AuthorizationStatusHandler = (CLAuthorizationStatus) -> Void

    // MARK: - Private Properties

    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.delegate = self
        return manager
    }()

    private var locationUpdateHandler: LocationUpdateHandler?
    private var authorizationStatusHandler: AuthorizationStatusHandler?

    // MARK: - Protocol Methods

    func updatingLocation(_ handler: LocationUpdateHandler?) {
        locationUpdateHandler = handler
    }

    func setAuthorizationStatusHandler(_ handler: AuthorizationStatusHandler?) {
        authorizationStatusHandler = handler
    }

    func requestLocation() {
        locationManager.requestLocation()
    }

    func requestWhenInUseAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
}

// MARK: - CLLocationManagerDelegate

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let geocoder = CLGeocoder()
        if let location = locations.last {
            locationUpdateHandler?(location, geocoder)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Не удалось получить местоположение пользователя: \(error.localizedDescription)")
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatusHandler?(manager.authorizationStatus)
    }
}

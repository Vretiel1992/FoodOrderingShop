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
    func getLastLocation() -> CLLocation?
}

final class LocationManager: NSObject, LocationManagerProtocol {

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

    private var lastLocation: CLLocation?

    // MARK: - Protocol Methods

    func getLastLocation() -> CLLocation? {
        lastLocation
    }

    func updatingLocation(_ handler: LocationUpdateHandler?) {
        locationUpdateHandler = handler
        if locationUpdateHandler != nil {
            locationManager.startUpdatingLocation()
        }
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
            lastLocation = location
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(Strings.LocationManager.Errors.failedToGetUserLocation + error.localizedDescription)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatusHandler?(manager.authorizationStatus)
    }
}

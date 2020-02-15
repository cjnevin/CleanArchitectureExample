//
//  LocationService.swift
//  CleanExample
//
//  Created by Chris on 08/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Combine
import CoreLocation
import Common

class LocationService: NSObject, AnyLocationService, CLLocationManagerDelegate {
    let locationManager = CLLocationManager()
    let location = CurrentValueSubject<Location?, Error>(nil)
    let locationStatus: AnyPublisher<LocationStatus, Error>

    override init() {
        locationStatus = location.map { location in
            location == nil ? LocationStatus.disabled : LocationStatus.enabled(location!)
        }.eraseToAnyPublisher()
        super.init()
    }

    func enableLocationService() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
    }

    func disableLocationService() {
        locationManager.stopUpdatingLocation()
        locationManager.delegate = nil
        location.send(.none)
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location.send(locationManager.location.map { $0.coordinate.location })
    }
}

private extension CLLocationCoordinate2D {
    var location: Location {
        Location(latitude: latitude, longitude: longitude)
    }
}

//
//  MockLocationService.swift
//  DomainTests
//
//  Created by Chris on 08/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Combine
import Domain
import Foundation

class MockLocationService: AnyLocationService {
    var spyStatus = CurrentValueSubject<LocationStatus?, Error>(nil)
    let locationStatus: AnyPublisher<LocationStatus, Error>
    init() {
        locationStatus = spyStatus.compactMap { $0 }.eraseToAnyPublisher()
    }

    func enableLocationService() {
        spyStatus.send(.enabled(Location(latitude: 1, longitude: 2)))
    }

    func disableLocationService() {
        spyStatus.send(.disabled)
    }
}

class MapCoordinator: AnyMapCoordinator {
    required init(dependencies: MapDependencies) {
        self.dependencies = dependencies
    }
    var dependencies: MapDependencies
}

final class MapView: AnyMapView {
    var spyLocation: Location?

    func updated(location: Location) {
        spyLocation = location
    }
}

//
//  AnyLocationService.swift
//  Domain
//
//  Created by Chris on 08/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Combine
import Foundation

public struct Location {
    public let latitude: Double
    public let longitude: Double

    public init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

public enum LocationStatus {
    case enabled(Location)
    case disabled
}

public protocol AnyLocationService {
    var locationStatus: AnyPublisher<LocationStatus, Error> { get }
    func enableLocationService()
    func disableLocationService()
}

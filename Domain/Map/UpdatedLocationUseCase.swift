//
//  UpdatedLocationUseCase.swift
//  Domain
//
//  Created by Chris on 09/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Combine
import Common

struct UpdatedLocationUseCase {
    let location: AnyLocationService

    func watch() -> AnyPublisher<Location, Error> {
        location.locationStatus.compactMap { status in
            if case .enabled(let location) = status {
                return location
            } else {
                return nil
            }
        }.eraseToAnyPublisher()
    }
}

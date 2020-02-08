//
//  ToggleLocationUseCase.swift
//  Domain
//
//  Created by Chris on 08/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

struct ToggleLocationUseCase {
    let dependencies: LocationServiceHaving

    func toggle(on: Bool) {
        if on {
            dependencies.location.enableLocationService()
        } else {
            dependencies.location.disableLocationService()
        }
    }
}

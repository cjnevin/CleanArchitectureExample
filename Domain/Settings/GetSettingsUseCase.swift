//
//  SettingsUseCase.swift
//  Domain
//
//  Created by Chris on 05/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

struct GetSettingsUseCase {
    let keyValues: AnyKeyValueStorage

    func get() -> StoredSettings {
        StoredSettings(
            notifications: keyValues.getSetting(key: "notifications", defaultValue: false),
            location: keyValues.getSetting(key: "location", defaultValue: false)
        )
    }
}

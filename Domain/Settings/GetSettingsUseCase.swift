//
//  SettingsUseCase.swift
//  Domain
//
//  Created by Chris on 05/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Common

struct GetSettingsUseCase {
    let keyValues: AnyKeyValueStore

    func get() -> StoredSettings {
        StoredSettings(
            notifications: keyValues.getSetting(key: "notifications", defaultValue: false),
            location: keyValues.getSetting(key: "location", defaultValue: false)
        )
    }
}

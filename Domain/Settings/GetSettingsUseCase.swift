//
//  SettingsUseCase.swift
//  Domain
//
//  Created by Chris on 05/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

struct GetSettingsUseCase {
    let settingStorage: SettingStorage

    func get() -> SettingsModel {
        SettingsModel(
            notifications: settingStorage.getSetting(key: "notifications", defaultValue: false),
            location: settingStorage.getSetting(key: "location", defaultValue: false)
        )
    }
}

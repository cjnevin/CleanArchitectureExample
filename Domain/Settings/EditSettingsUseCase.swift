//
//  SetSettingUseCase.swift
//  Domain
//
//  Created by Chris on 05/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

struct EditSettingsUseCase {
    let settingStorage: SettingStorage

    func edit(settings: SettingsModel) {
        settingStorage.setSetting(settings.notifications)
        settingStorage.setSetting(settings.location)
    }
}

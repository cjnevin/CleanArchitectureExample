//
//  SetSettingUseCase.swift
//  Domain
//
//  Created by Chris on 05/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

struct EditSettingsUseCase {
    let keyValues: AnyKeyValueStore

    func edit(settings: StoredSettings) {
        keyValues.setSetting(settings.notifications)
        keyValues.setSetting(settings.location)
    }
}

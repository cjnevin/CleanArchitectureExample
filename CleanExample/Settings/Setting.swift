//
//  Setting.swift
//  CleanExample
//
//  Created by Chris on 08/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain

struct Setting: AnySetting {
    let name: String
    let value: SettingValue

    init(key: String, value: SettingValue) {
        self.name = key == "notifications" ? "Enable Notifications" : "Enable Location"
        self.value = value
    }
}

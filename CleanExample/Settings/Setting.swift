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
        switch key {
        case "notifications": self.name = "Enable Notifications"
        case "location": self.name = "Enable Location"
        case "remove_product_list": self.name = "Hide Products"
        case "add_product_list": self.name = "Show Products"
        default: self.name = ""
        }
        self.value = value
    }
}

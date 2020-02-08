//
//  SettingStorage.swift
//  Domain
//
//  Created by Chris on 05/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

public protocol SettingStorage {
    func get<Value>(key: String, defaultValue: Value) -> Value
    func set<Value>(_ object: Value, key: String)
}

extension SettingStorage {
    func getSetting<Value>(key: String, defaultValue: Value) -> StoredSetting<Value> {
        let value = get(key: key, defaultValue: defaultValue)
        return StoredSetting(key: key, value: value)
    }

    func setSetting<Value>(_ setting: StoredSetting<Value>) {
        set(setting.value, key: setting.key)
    }
}

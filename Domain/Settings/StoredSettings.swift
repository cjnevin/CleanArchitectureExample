//
//  StoredSettings.swift
//  Domain
//
//  Created by Chris on 15/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Common

struct StoredSettings {
    var notifications: KeyValue<Bool>
    var location: KeyValue<Bool>
}

extension AnyKeyValueStore {
    func getSetting<Value>(key: String, defaultValue: Value) -> KeyValue<Value> {
        let value = get(key: key, defaultValue: defaultValue)
        return KeyValue(key: key, value: value)
    }

    func setSetting<Value>(_ setting: KeyValue<Value>) {
        set(setting.value, key: setting.key)
    }
}

struct KeyValue<Value> {
    let key: String
    var value: Value
}

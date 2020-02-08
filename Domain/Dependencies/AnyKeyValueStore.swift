//
//  AnyKeyValueStore.swift
//  Domain
//
//  Created by Chris on 05/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

public protocol AnyKeyValueStore {
    func get<Value>(key: String, defaultValue: Value) -> Value
    func set<Value>(_ object: Value, key: String)
}

// MARK: - Internal

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

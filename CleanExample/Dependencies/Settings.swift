//
//  Settings.swift
//  CleanExample
//
//  Created by Chris on 05/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Common

class Settings: AnyKeyValueStore {
    let userDefaults: UserDefaults = .standard

    func get<Value>(key: String, defaultValue: Value) -> Value {
        (userDefaults.value(forKey: key) as? Value) ?? defaultValue
    }

    func set<Value>(_ object: Value, key: String) {
        userDefaults.set(object, forKey: key)
    }
}

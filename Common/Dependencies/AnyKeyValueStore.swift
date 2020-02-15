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

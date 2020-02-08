//
//  SettingsModel.swift
//  Domain
//
//  Created by Chris on 05/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

struct StoredSetting<Value> {
    let key: String
    var value: Value
}

struct StoredSettings {
    var notifications: StoredSetting<Bool>
    var location: StoredSetting<Bool>
}

public enum SettingValue {
    case onOff(Bool, toggle: () -> Void)
}

public protocol Setting {
    var name: String { get }
    var value: SettingValue { get }
    init(key: String, value: SettingValue)
}

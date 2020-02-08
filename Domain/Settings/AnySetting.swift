//
//  SettingsModel.swift
//  Domain
//
//  Created by Chris on 05/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

public protocol AnySetting {
    var name: String { get }
    var value: SettingValue { get }
    init(key: String, value: SettingValue)
}

public enum SettingValue {
    case onOff(Bool, toggle: () -> Void)
}

struct StoredSettings {
    var notifications: KeyValue<Bool>
    var location: KeyValue<Bool>
}

//
//  SettingsModel.swift
//  Domain
//
//  Created by Chris on 05/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

public struct Setting<Value> {
    public let key: String
    public var value: Value
}

public struct SettingsModel {
    public var notifications: Setting<Bool>
    public var location: Setting<Bool>
}

//
//  SettingsCoordinating.swift
//  Domain
//
//  Created by Chris on 06/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

public typealias SettingsDependencies = SettingStorageHaving

public protocol SettingsCoordinating {
    init(dependencies: SettingsDependencies)
    var dependencies: SettingsDependencies { get }
}

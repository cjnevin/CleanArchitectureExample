//
//  SettingsCoordinating.swift
//  Domain
//
//  Created by Chris on 06/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

public typealias SettingsDependencies = KeyValueStorageHaving & LocationServiceHaving & NotificationServiceHaving & DatabaseHaving

public protocol AnySettingsCoordinator {
    init<TabCoordinator: AnyTabCoordinator>(dependencies: SettingsDependencies, tabCoordinator: TabCoordinator)
    var dependencies: SettingsDependencies { get }
}
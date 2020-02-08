//
//  AnyNotificationsCoordinator.swift
//  Domain
//
//  Created by Chris on 08/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

public typealias NotificationsDependencies = DatabaseHaving & NotificationServiceHaving

public protocol NotificationsCoordinating {
    init(dependencies: NotificationsDependencies)
    var dependencies: NotificationsDependencies { get }
}

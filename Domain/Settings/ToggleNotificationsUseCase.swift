//
//  ToggleNotificationsUseCase.swift
//  Domain
//
//  Created by Chris on 08/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Combine
import Foundation

struct ToggleNotificationsUseCase<TabCoordinator: TabCoordinating> {
    let dependencies: DatabaseHaving & NotificationServiceHaving
    let tabCoordinator: TabCoordinator
    let dropNotificationsUseCase: DropNotificationsUseCase

    init(dependencies: DatabaseHaving & NotificationServiceHaving,
         tabCoordinator: TabCoordinator) {
        self.dependencies = dependencies
        self.tabCoordinator = tabCoordinator
        self.dropNotificationsUseCase = DropNotificationsUseCase(database: dependencies.database)
    }

    func toggle(on: Bool) {
        if on {
            dependencies.notification.enableNotificationService()
            if !tabCoordinator.hasNotifications {
                tabCoordinator.insertNotifications()
            }
        } else {
            dependencies.notification.disableNotificationService()
            dropNotificationsUseCase.drop()
            if tabCoordinator.hasNotifications {
                tabCoordinator.removeNotifications()
            }
        }
    }
}

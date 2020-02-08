//
//  TabStartUseCase.swift
//  Domain
//
//  Created by Chris on 08/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Combine
import Foundation

struct TabStartUseCase<TabCoordinator: AnyTabCoordinator> {
    let dependencies: AnyDependencies
    let tabCoordinator: TabCoordinator

    func start() -> [AnyCancellable] {
        tabCoordinator.addTab(TabCoordinator.ProductListCoordinator(dependencies: dependencies))
        tabCoordinator.addTab(TabCoordinator.SettingsCoordinator(dependencies: dependencies, tabCoordinator: tabCoordinator))

        let settings = GetSettingsUseCase(keyValues: dependencies.keyValues).get()
        if settings.location.value {
            dependencies.location.enableLocationService()
        }
        if settings.notifications.value {
            dependencies.notification.enableNotificationService()
            tabCoordinator.insertNotifications()
        }
        return [
            StoreNotificationsUseCase(dependencies: dependencies).continuously(),
            InsertMapTabUseCase(dependencies: dependencies, tabCoordinator: tabCoordinator).watch()
        ]
    }
}

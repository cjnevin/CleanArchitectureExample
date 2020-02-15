//
//  TabStartUseCase.swift
//  Domain
//
//  Created by Chris on 08/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Combine
import Common

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

extension AnyTabCoordinator {
    public func start() {
        cancellables = TabStartUseCase(dependencies: dependencies, tabCoordinator: self).start()
    }
    
    func insertNotifications() {
        insertTab(NotificationsCoordinator(dependencies: dependencies), at: hasProductList ? 1 : 0)
    }

    var hasNotifications: Bool {
        index(of: NotificationsCoordinator.self) != nil
    }

    func removeNotifications() {
        removeTab(NotificationsCoordinator.self)
    }

    func insertMap() {
        var index = 0
        if hasProductList { index += 1 }
        if hasNotifications { index += 1 }
        insertTab(MapCoordinator(dependencies: dependencies), at: index)
    }

    var hasMap: Bool {
        index(of: MapCoordinator.self) != nil
    }

    func removeMap() {
        removeTab(MapCoordinator.self)
    }

    func insertProductList() {
        insertTab(ProductListCoordinator(dependencies: dependencies), at: 0)
    }

    var hasProductList: Bool {
        index(of: ProductListCoordinator.self) != nil
    }

    func removeProductList() {
        removeTab(ProductListCoordinator.self)
    }
}

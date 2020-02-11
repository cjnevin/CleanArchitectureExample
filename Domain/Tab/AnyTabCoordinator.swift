//
//  AnyTabCoordinator.swift
//  Domain
//
//  Created by Chris on 05/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Combine
import Foundation

public protocol AnyTabCoordinator: AnyObject {
    associatedtype ProductListCoordinator: AnyProductListCoordinator
    associatedtype MapCoordinator: AnyMapCoordinator
    associatedtype NotificationsCoordinator: AnyNotificationsCoordinator
    associatedtype SettingsCoordinator: SettingsCoordinating
    var dependencies: AnyDependencies { get }
    var cancellables: [AnyCancellable] { get set }
    init(dependencies: AnyDependencies)
    func start()
    func addTab(_ any: Any)
    func insertTab(_ any: Any, at index: Int)
    func index<T>(of type: T.Type) -> Int?
    func showTab<T>(_ type: T.Type)
    func removeTab<T>(_ type: T.Type)
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

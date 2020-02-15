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
    associatedtype SettingsCoordinator: AnySettingsCoordinator
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

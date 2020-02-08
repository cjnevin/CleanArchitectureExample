//
//  TabCoordinating.swift
//  Domain
//
//  Created by Chris on 05/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

public protocol TabCoordinating {
    associatedtype ProductListCoordinator: ProductListCoordinating
    associatedtype SettingsCoordinator: SettingsCoordinating
    var dependencies: AnyDependencies { get }
    init(dependencies: AnyDependencies)
    func start()
    func addTab(_ any: Any)
    func insertTab(_ any: Any, at index: Int)
    func index<T>(of type: T.Type) -> Int?
    func showTab<T>(_ type: T.Type)
    func removeTab<T>(_ type: T.Type)
}

extension TabCoordinating {
    public func start() {
        addTab(ProductListCoordinator(dependencies: dependencies))
        addTab(SettingsCoordinator(dependencies: dependencies, tabCoordinator: self))
    }

    func addProductList() {
        insertTab(ProductListCoordinator(dependencies: dependencies), at: 0)
    }

    var hasProductList: Bool {
        index(of: ProductListCoordinator.self) != nil
    }

    func removeProductList() {
        removeTab(ProductListCoordinator.self)
    }
}

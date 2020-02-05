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
    var dependencies: Dependencies { get }
    init(dependencies: Dependencies)
    func start()
    func addTab(_ any: Any)
    func showTab<T>(_ type: T.Type)
    func removeTab<T>(_ type: T.Type)
}

extension TabCoordinating {
    public func start() {
        addTab(ProductListCoordinator(dependencies: dependencies))
        addTab(SettingsCoordinator(dependencies: dependencies))
    }
}

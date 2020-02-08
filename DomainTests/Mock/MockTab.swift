//
//  MockTab.swift
//  DomainTests
//
//  Created by Chris on 06/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import Foundation

class TabCoordinator: TabCoordinating {
    func index<T>(of type: T.Type) -> Int? {
        spyTabs.firstIndex(where: { $0 is T })
    }

    typealias ProductListCoordinator = DomainTests.ProductListCoordinator
    typealias SettingsCoordinator = DomainTests.SettingsCoordinator

    var dependencies: AnyDependencies
    required init(dependencies: AnyDependencies) {
        self.dependencies = dependencies
    }

    var spyTabs: [Any] = []
    func addTab(_ any: Any) {
        spyTabs.append(any)
    }

    func insertTab(_ any: Any, at index: Int) {
        spyTabs.insert(any, at: index)
    }

    func removeTab<T>(_ type: T.Type) {
        spyTabs.removeAll(where: { $0 is T })
    }

    var spyShownTab: Any?
    func showTab<T>(_ type: T.Type) {
        spyShownTab = spyTabs.first(where: { $0 is T })
    }
}

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
        if tabCoordinator.hasProductList {
            tabCoordinator.removeProductList()
        }
        tabCoordinator.insertProductList()
        return []
    }
}

extension AnyTabCoordinator {
    public func start() {
        cancellables = TabStartUseCase(dependencies: dependencies, tabCoordinator: self).start()
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

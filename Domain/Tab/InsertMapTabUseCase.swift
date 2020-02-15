//
//  InsertMapTabUseCase.swift
//  Domain
//
//  Created by Chris on 08/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Combine
import Common

struct InsertMapTabUseCase<TabCoordinator: AnyTabCoordinator> {
    let dependencies: DatabaseHaving & LocationServiceHaving
    let tabCoordinator: TabCoordinator

    func watch() -> AnyCancellable {
        dependencies.location.locationStatus.map { status in
            if !self.tabCoordinator.hasMap, case .enabled = status {
                self.tabCoordinator.insertMap()
            } else if self.tabCoordinator.hasMap, case .disabled = status {
                self.tabCoordinator.removeMap()
            }
        }.sink(receiveCompletion: { _ in }, receiveValue: { _ in })
    }
}

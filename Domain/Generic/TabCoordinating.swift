//
//  TabCoordinating.swift
//  Domain
//
//  Created by Chris on 05/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Combine
import Foundation

public protocol TabCoordinating: AnyObject {
    associatedtype ProductListCoordinator: ProductListCoordinating
    associatedtype MapCoordinator: MapCoordinating
    associatedtype SettingsCoordinator: SettingsCoordinating
    var dependencies: AnyDependencies { get }
    var locationCancellable: AnyCancellable? { get set }
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

        if GetSettingsUseCase(keyValues: dependencies.keyValues).get().location.value {
            dependencies.location.enableLocationService()
        }

        locationCancellable?.cancel()
        locationCancellable = dependencies.location.locationStatus.sink(receiveCompletion: { _ in

        }, receiveValue: { status in
            if !self.hasMap, case .enabled = status {
                self.insertMap()
            } else if self.hasMap, case .disabled = status {
                self.removeMap()
            }
        })
    }

    func insertMap() {
        insertTab(MapCoordinator(dependencies: dependencies), at: hasProductList ? 1 : 0)
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

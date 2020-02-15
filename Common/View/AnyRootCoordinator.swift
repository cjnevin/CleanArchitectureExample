//
//  AnyRootCoordinator.swift
//  Domain
//
//  Created by Chris on 04/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

public protocol AnyRootCoordinator {
    associatedtype TabCoordinator: AnyTabCoordinator
    var dependencies: AnyDependencies { get }
    func start()
    func setRoot(_ any: Any)
}

public extension AnyRootCoordinator {
    func start() {
        setRoot(TabCoordinator(dependencies: dependencies))
    }
}

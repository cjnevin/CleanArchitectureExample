//
//  RootCoordinating.swift
//  Domain
//
//  Created by Chris on 04/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

public protocol RootCoordinating {
    associatedtype TabCoordinator: TabCoordinating
    var dependencies: Dependencies { get }
    func start()
    func setRoot(_ any: Any)
}

public extension RootCoordinating {
    func start() {
        setRoot(TabCoordinator(dependencies: dependencies))
    }
}

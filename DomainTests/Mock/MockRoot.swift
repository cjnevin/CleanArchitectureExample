//
//  MockRoot.swift
//  DomainTests
//
//  Created by Chris on 06/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import Foundation

class RootCoordinator: RootCoordinating {
    typealias TabCoordinator = DomainTests.TabCoordinator

    var dependencies: AnyDependencies
    init(dependencies: AnyDependencies) {
        self.dependencies = dependencies
    }

    var spyRoot: Any?
    func setRoot(_ any: Any) {
        spyRoot = any
    }
}

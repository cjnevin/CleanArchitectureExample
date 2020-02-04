//
//  MainTests.swift
//  DomainTests
//
//  Created by Chris on 04/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import Foundation
import XCTest

class MainTests: XCTestCase {
    var coordinator: RootCoordinator!

    override func setUp() {
        super.setUp()
        coordinator = RootCoordinator(dependencies: MockDependencies())
    }

    func testStartSetsRootToProductList() {
        coordinator.start()
        XCTAssertNotNil(coordinator.spyRoot)
        XCTAssert(coordinator.spyRoot is ProductListCoordinator)
    }
}

class RootCoordinator: RootCoordinating {
    typealias ProductListCoordinator = DomainTests.ProductListCoordinator

    var dependencies: Dependencies
    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }

    var spyRoot: Any?
    func setRoot(_ any: Any) {
        spyRoot = any
    }
}

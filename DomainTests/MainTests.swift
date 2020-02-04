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
    var coordinator: MainCoordinator!

    override func setUp() {
        super.setUp()
        coordinator = MainCoordinator(dependencies: Dependencies())
    }

    func testStartSetsRootToProductList() {
        coordinator.start()
        XCTAssertNotNil(coordinator.spyRoot)
        XCTAssert(coordinator.spyRoot is ProductListCoordinator)
    }
}

class MainCoordinator: IMainCoordinator {
    typealias ProductListCoordinator = DomainTests.ProductListCoordinator

    var dependencies: IDependencies
    init(dependencies: IDependencies) {
        self.dependencies = dependencies
    }

    var spyRoot: Any?
    func setRoot(_ any: Any) {
        spyRoot = any
    }
}

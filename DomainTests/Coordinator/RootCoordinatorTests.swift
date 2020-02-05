//
//  RootCoordinatorTests.swift
//  DomainTests
//
//  Created by Chris on 04/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import Foundation
import XCTest

class RootCoordinatorTests: XCTestCase {
    var coordinator: RootCoordinator!

    override func setUp() {
        super.setUp()
        coordinator = RootCoordinator(dependencies: MockDependencies())
    }

    func testStartSetsRootToTabCoordinator() {
        coordinator.start()
        XCTAssertNotNil(coordinator.spyRoot)
        XCTAssert(coordinator.spyRoot is TabCoordinator)
    }
}

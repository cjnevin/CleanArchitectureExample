//
//  TabCoordinatorTests.swift
//  DomainTests
//
//  Created by Chris on 06/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Common
import Domain
import XCTest

class TabCoordinatorTests: XCTestCase {
    var coordinator: TabCoordinator!

    override func setUp() {
        super.setUp()
        coordinator = TabCoordinator(dependencies: MockDependencies())
    }

    func testStartAddsProduct() {
        coordinator!.start()
        XCTAssertEqual(coordinator.spyTabs.count, 1)
        XCTAssertNotNil(coordinator.spyTabs.first as? ProductListCoordinator)
    }
}

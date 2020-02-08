//
//  TabCoordinatorTests.swift
//  DomainTests
//
//  Created by Chris on 06/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import Foundation
import XCTest

class TabCoordinatorTests: XCTestCase {
    var coordinator: TabCoordinator!

    override func setUp() {
        super.setUp()
        coordinator = TabCoordinator(dependencies: MockDependencies())
    }

    func testStartAddsProductAndSettingsTabs() {
        coordinator!.start()
        XCTAssertEqual(coordinator.spyTabs.count, 2)
        XCTAssertNotNil(coordinator.spyTabs.first as? ProductListCoordinator)
        XCTAssertNotNil(coordinator.spyTabs.last as? SettingsCoordinator)
    }
}

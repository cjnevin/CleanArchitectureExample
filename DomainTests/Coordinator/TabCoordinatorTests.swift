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
    var keyValues: MockSettingsStorage!
    var coordinator: TabCoordinator!

    override func setUp() {
        super.setUp()
        keyValues = MockSettingsStorage()
        coordinator = TabCoordinator(dependencies: MockDependencies(keyValues: keyValues))
    }

    func testStartAddsProductAndSettingsTabs() {
        coordinator!.start()
        XCTAssertEqual(coordinator.spyTabs.count, 2)
        XCTAssertNotNil(coordinator.spyTabs.first as? ProductListCoordinator)
        XCTAssertNotNil(coordinator.spyTabs.last as? SettingsCoordinator)
    }

    func testStartAddsProductMapAndSettingsTabs() {
        keyValues.set(true, key: "location")
        coordinator!.start()
        XCTAssertEqual(coordinator.spyTabs.count, 3)
        XCTAssertNotNil(coordinator.spyTabs.first as? ProductListCoordinator)
        XCTAssertNotNil(coordinator.spyTabs[1] as? MapCoordinator)
        XCTAssertNotNil(coordinator.spyTabs.last as? SettingsCoordinator)
    }

    func testStartAddsProductNotificationsAndSettingsTabs() {
        keyValues.set(true, key: "notifications")
        coordinator!.start()
        XCTAssertEqual(coordinator.spyTabs.count, 3)
        XCTAssertNotNil(coordinator.spyTabs.first as? ProductListCoordinator)
        XCTAssertNotNil(coordinator.spyTabs[1] as? NotificationsCoordinator)
        XCTAssertNotNil(coordinator.spyTabs.last as? SettingsCoordinator)
    }

    func testStartAddsProductMapNotificationsAndSettingsTabs() {
        keyValues.set(true, key: "location")
        keyValues.set(true, key: "notifications")
        coordinator!.start()
        XCTAssertEqual(coordinator.spyTabs.count, 4)
        XCTAssertNotNil(coordinator.spyTabs.first as? ProductListCoordinator)
        XCTAssertNotNil(coordinator.spyTabs[1] as? NotificationsCoordinator)
        XCTAssertNotNil(coordinator.spyTabs[2] as? MapCoordinator)
        XCTAssertNotNil(coordinator.spyTabs.last as? SettingsCoordinator)
    }
}

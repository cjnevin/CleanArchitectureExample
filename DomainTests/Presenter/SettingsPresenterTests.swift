//
//  SettingsCoordinatorTests.swift
//  DomainTests
//
//  Created by Chris on 06/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Common
import Domain
import Foundation
import XCTest

class SettingsPresenterTests: XCTestCase {
    var keyValues: MockSettingsStorage!
    var coordinator: SettingsCoordinator!
    var tabCoordinator: TabCoordinator!
    var presenter: SettingsPresenter<SettingsView, SettingsCoordinator, TabCoordinator>!

    override func setUp() {
        super.setUp()
        keyValues = MockSettingsStorage()
        let dependencies = MockDependencies(keyValues: keyValues)
        tabCoordinator = TabCoordinator(dependencies: dependencies)
        coordinator = SettingsCoordinator(dependencies: dependencies, tabCoordinator: tabCoordinator)
        presenter = SettingsPresenter(coordinator: coordinator, tabCoordinator: tabCoordinator)
        tabCoordinator.start()
    }

    func testAttachAndDetach() {
        let view = SettingsView()
        XCTAssertTrue(view.settings.isEmpty)
        presenter.attach(view: view)
        XCTAssertFalse(view.settings.isEmpty)
        presenter.detach()
        XCTAssertTrue(view.settings.isEmpty)
    }

    func testModifySettings() {
        let view = SettingsView()
        presenter.attach(view: view)
        XCTAssertEqual(keyValues.spyGetCount, 4)
        XCTAssertFalse(keyValues.get(key: "location", defaultValue: false))
        XCTAssertFalse(keyValues.get(key: "notifications", defaultValue: false))
        XCTAssertEqual(tabCoordinator.spyTabs.count, 2)
        view.settings.forEach { item in
            switch item.value {
            case .action: break
            case let .onOff(_, toggle): toggle()
            }
        }
        XCTAssertEqual(keyValues.spySetCount, 4)
        XCTAssertTrue(keyValues.get(key: "location", defaultValue: false))
        XCTAssertTrue(keyValues.get(key: "notifications", defaultValue: false))
        XCTAssertEqual(tabCoordinator.spyTabs.count, 4)
        view.settings.forEach { item in
            switch item.value {
            case .action: break
            case let .onOff(_, toggle): toggle()
            }
        }
        XCTAssertEqual(keyValues.spySetCount, 8)
        XCTAssertFalse(keyValues.get(key: "location", defaultValue: false))
        XCTAssertFalse(keyValues.get(key: "notifications", defaultValue: false))
        XCTAssertEqual(tabCoordinator.spyTabs.count, 2)
    }

    func testRemoveAndAddProductList() {
        // Note: TabCoordinator contains no tabs because start() is not called
        let view = SettingsView()
        presenter.attach(view: view)
        XCTAssertNotNil(tabCoordinator.index(of: TabCoordinator.ProductListCoordinator.self))
        view.settings.forEach { item in
            switch item.value {
            case let .action(action): action()
            case .onOff: break
            }
        }
        XCTAssertNil(tabCoordinator.index(of: TabCoordinator.ProductListCoordinator.self))
        view.settings.forEach { item in
            switch item.value {
            case let .action(action): action()
            case .onOff: break
            }
        }
        XCTAssertNotNil(tabCoordinator.index(of: TabCoordinator.ProductListCoordinator.self))
    }
}

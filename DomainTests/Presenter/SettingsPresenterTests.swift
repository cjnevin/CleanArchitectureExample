//
//  SettingsCoordinatorTests.swift
//  DomainTests
//
//  Created by Chris on 06/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import Foundation
import XCTest

class SettingsPresenterTests: XCTestCase {
    var keyValues: MockSettingsStorage!
    var coordinator: SettingsCoordinator!
    var presenter: SettingsPresenter<SettingsView, SettingsCoordinator>!

    override func setUp() {
        super.setUp()
        keyValues = MockSettingsStorage()
        coordinator = SettingsCoordinator(dependencies: MockDependencies(keyValues: keyValues))
        presenter = SettingsPresenter(coordinator: coordinator)
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
        XCTAssertEqual(keyValues.spyGetCount, 2)
        XCTAssertFalse(keyValues.get(key: "location", defaultValue: false))
        XCTAssertFalse(keyValues.get(key: "notifications", defaultValue: false))
        view.settings.forEach { item in
            switch item.value {
            case let .onOff(_, toggle): toggle()
            }
        }
        XCTAssertEqual(keyValues.spySetCount, 4)
        XCTAssertTrue(keyValues.get(key: "location", defaultValue: false))
        XCTAssertTrue(keyValues.get(key: "notifications", defaultValue: false))
    }
}

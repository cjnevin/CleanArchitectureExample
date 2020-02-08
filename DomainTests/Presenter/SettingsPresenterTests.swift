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
    var settingStorage: MockSettingsStorage!
    var coordinator: SettingsCoordinator!
    var presenter: SettingsPresenter<SettingsView, SettingsCoordinator>!

    override func setUp() {
        super.setUp()
        settingStorage = MockSettingsStorage()
        coordinator = SettingsCoordinator(dependencies: MockDependencies(settingStorage: settingStorage))
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
        XCTAssertEqual(settingStorage.spyGetCount, 2)
        XCTAssertFalse(settingStorage.get(key: "location", defaultValue: false))
        XCTAssertFalse(settingStorage.get(key: "notifications", defaultValue: false))
        view.settings.forEach { item in
            switch item.value {
            case let .onOff(_, toggle): toggle()
            }
        }
        XCTAssertEqual(settingStorage.spySetCount, 4)
        XCTAssertTrue(settingStorage.get(key: "location", defaultValue: false))
        XCTAssertTrue(settingStorage.get(key: "notifications", defaultValue: false))
    }
}

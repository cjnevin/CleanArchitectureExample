//
//  NotificationsPresenterTests.swift
//  DomainTests
//
//  Created by Chris on 09/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import Foundation
import XCTest

class NotificationPresenterTests: XCTestCase {
    var notificationService: MockNotificationService!
    var dependencies: MockDependencies!
    var coordinator: NotificationsCoordinator!
    var presenter: NotificationsPresenter<NotificationsView, NotificationsCoordinator>!

    override func setUp() {
        super.setUp()
        notificationService = MockNotificationService()
        dependencies = MockDependencies(notification: notificationService)
        coordinator = NotificationsCoordinator(dependencies: dependencies)
        presenter = NotificationsPresenter(coordinator: coordinator)
    }

    func testAttachClearDetach() {
        notificationService.enableNotificationService()
        let view = NotificationsView()
        presenter.attach(view: view)
        XCTAssertFalse(view.sections.isEmpty)
        presenter.clear()
        presenter.detach()
    }
}

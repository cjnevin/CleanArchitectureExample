//
//  MockNotificationService.swift
//  DomainTests
//
//  Created by Chris on 08/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Combine
import Common

class MockNotificationService: AnyNotificationService {
    let spyStatus = CurrentValueSubject<NotificationsStatus?, Error>(nil)
    let notificationStatus: AnyPublisher<NotificationsStatus, Error>
    init() {
        notificationStatus = spyStatus.compactMap { $0 }.eraseToAnyPublisher()
    }

    func enableNotificationService() {
        spyStatus.send(.enabled(.init(title: "title", body: "body")))
    }

    func disableNotificationService() {
        spyStatus.send(.disabled)
    }
}

class NotificationsCoordinator: AnyNotificationsCoordinator {
    required init(dependencies: NotificationsDependencies) {
        self.dependencies = dependencies
    }
    var dependencies: NotificationsDependencies
}

final class NotificationsView: AnyNotificationsView {
    var sections: [Section<Common.Notification>] = []
}

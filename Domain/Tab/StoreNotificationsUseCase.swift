//
//  StoreNotificationsUseCase.swift
//  Domain
//
//  Created by Chris on 08/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Combine
import Common

struct StoreNotificationsUseCase {
    let dependencies: DatabaseHaving & NotificationServiceHaving

    func continuously() -> AnyCancellable {
        dependencies.notification.notificationStatus.map { status in
            if case .enabled(let value) = status {
                self.dependencies.database.set(value, id: UUID().uuidString)
            }
        }.sink(receiveCompletion: { _ in }, receiveValue: { _ in })
    }
}

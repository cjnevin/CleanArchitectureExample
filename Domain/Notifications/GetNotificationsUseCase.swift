//
//  GetNotificationsUseCase.swift
//  Domain
//
//  Created by Chris on 08/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Combine
import Foundation

struct GetNotificationsUseCase {
    let database: AnyDatabase
    init(database: AnyDatabase) {
        self.database = database
    }

    func list() -> AnyPublisher<[Notification], Error> {
        database.list().map { $0.sorted() }.eraseToAnyPublisher()
    }
}

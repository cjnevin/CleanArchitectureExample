//
//  Dependencies.swift
//  DomainTests
//
//  Created by Chris on 04/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Common

class MockDependencies: AnyDependencies {
    let api: AnyAPI
    let database: AnyDatabase
    let keyValues: AnyKeyValueStore
    let location: AnyLocationService
    let notification: AnyNotificationService

    init(api: AnyAPI = MockRequestExecutor(),
         database: AnyDatabase = MockDatabase(),
         keyValues: AnyKeyValueStore = MockSettingsStorage(),
         location: AnyLocationService = MockLocationService(),
         notification: AnyNotificationService = MockNotificationService())
    {
        self.api = api
        self.database = database
        self.keyValues = keyValues
        self.location = location
        self.notification = notification
    }
}

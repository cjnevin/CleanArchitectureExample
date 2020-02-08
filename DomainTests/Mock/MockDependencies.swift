//
//  Dependencies.swift
//  DomainTests
//
//  Created by Chris on 04/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import Foundation

class MockDependencies: AnyDependencies {
    let api: AnyAPI
    let database: AnyDatabase
    let keyValues: AnyKeyValueStore

    init(api: AnyAPI = MockRequestExecutor(),
         database: AnyDatabase = MockDatabase(),
         keyValues: AnyKeyValueStore = MockSettingsStorage())
    {
        self.api = api
        self.database = database
        self.keyValues = keyValues
    }
}

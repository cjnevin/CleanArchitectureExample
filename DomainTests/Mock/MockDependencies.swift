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
    let database: AnyDatabase
    let keyValues: AnyKeyValueStorage
    let requestExecutor: AnyRequestExecutor

    init(database: AnyDatabase = MockDatabase(),
         keyValues: AnyKeyValueStorage = MockSettingsStorage(),
         requestExecutor: AnyRequestExecutor = MockRequestExecutor())
    {
        self.database = database
        self.keyValues = keyValues
        self.requestExecutor = requestExecutor
    }
}

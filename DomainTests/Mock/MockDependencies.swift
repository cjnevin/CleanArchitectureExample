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

    init(api: AnyAPI = MockRequestExecutor(),
         database: AnyDatabase = MockDatabase())
    {
        self.api = api
        self.database = database
    }
}

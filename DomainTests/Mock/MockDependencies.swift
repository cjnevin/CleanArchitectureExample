//
//  Dependencies.swift
//  DomainTests
//
//  Created by Chris on 04/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import Foundation

class MockDependencies: Dependencies {
    let api: Requestable
    let database: Storable

    init(api: Requestable = MockAPIService(),
         database: Storable = MockDatabase()) {
        self.api = api
        self.database = database
    }
}

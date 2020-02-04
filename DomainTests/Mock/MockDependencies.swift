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
    let modelStorage: ModelStorage
    let requestExecutor: RequestExecutor

    init(modelStorage: ModelStorage = MockDatabase(),
         requestExecutor: RequestExecutor = MockRequestExecutor())
    {
        self.modelStorage = modelStorage
        self.requestExecutor = requestExecutor
    }
}

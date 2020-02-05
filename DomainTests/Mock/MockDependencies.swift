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
    let settingStorage: SettingStorage
    let modelStorage: ModelStorage
    let requestExecutor: RequestExecutor

    init(settingStorage: SettingStorage = MockSettingsStorage(),
         modelStorage: ModelStorage = MockDatabase(),
         requestExecutor: RequestExecutor = MockRequestExecutor())
    {
        self.settingStorage = settingStorage
        self.modelStorage = modelStorage
        self.requestExecutor = requestExecutor
    }
}

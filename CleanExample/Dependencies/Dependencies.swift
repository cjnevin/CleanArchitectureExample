//
//  Dependencies.swift
//  CleanExample
//
//  Created by Chris on 04/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import Foundation

class AllDependencies: Dependencies {
    let requestExecutor: RequestExecutor = API()
    let modelStorage: ModelStorage = Database()
}

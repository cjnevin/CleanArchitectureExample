//
//  Dependencies.swift
//  CleanExample
//
//  Created by Chris on 04/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import Foundation

class Dependencies: AnyDependencies {
    let keyValues: AnyKeyValueStore = Settings()
    let api: AnyAPI = API()
    let database: AnyDatabase = Database()
}

//
//  Dependencies.swift
//  CleanExample
//
//  Created by Chris on 04/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Common

class Dependencies: AnyDependencies {
    let api: AnyAPI = API()
    let database: AnyDatabase = Database()
}

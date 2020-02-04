//
//  Dependencies.swift
//  DomainTests
//
//  Created by Chris on 04/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import Foundation

class Dependencies: IDependencies {
    let api: IAPIService
    let database: IDatabase

    init(api: IAPIService = APIService(),
         database: IDatabase = Database()) {
        self.api = api
        self.database = database
    }
}

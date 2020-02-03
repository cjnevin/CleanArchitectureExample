//
//  GetProductListUseCase.swift
//  Domain
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 cjnevin. All rights reserved.
//

import Foundation

struct GetProductListUseCase<Product: IProduct> {
    let database: IDatabase

    init(database: IDatabase) {
        self.database = database
    }

    func list() -> [Product] {
        database.list().sorted()
    }
}

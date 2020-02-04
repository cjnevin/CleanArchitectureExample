//
//  GetProductUseCase.swift
//  Domain
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 cjnevin. All rights reserved.
//

import Foundation

struct GetProductUseCase<Product: IProduct> {
    let id: String
    let database: IDatabase

    func get() -> Product {
        database.get(id: id)
    }
}

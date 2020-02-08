//
//  GetProductUseCase.swift
//  Domain
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 cjnevin. All rights reserved.
//

import Foundation

struct GetProductUseCase<Product: AnyProduct> {
    let id: String
    let database: AnyDatabase

    func get() -> Product {
        database.get(id: id)
    }
}

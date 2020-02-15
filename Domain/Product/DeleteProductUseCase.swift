//
//  DeleteProductUseCase.swift
//  Domain
//
//  Created by Chris on 06/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Common

struct DeleteProductUseCase<Product: AnyProduct> {
    let database: AnyDatabase

    @discardableResult func delete(id: String) -> Product {
        database.delete(id: id)
    }
}

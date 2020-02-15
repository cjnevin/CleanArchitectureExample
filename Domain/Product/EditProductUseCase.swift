//
//  EditProductUseCase.swift
//  Domain
//
//  Created by Chris on 04/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Common

struct EditProductUseCase<Product: AnyProduct> {
    let id: String
    let database: AnyDatabase

    func edit(name: String) {
        var product: Product = database.get(id: id)
        product.name = name
        database.set(product, id: id)
    }
}

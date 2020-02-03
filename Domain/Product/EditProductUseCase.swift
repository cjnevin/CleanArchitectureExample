//
//  EditProductUseCase.swift
//  Domain
//
//  Created by Chris on 04/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

struct EditProductUseCase<Product: IProduct> {
    let database: IDatabase
    let id: String

    init(id: String, database: IDatabase) {
        self.id = id
        self.database = database
    }

    func edit(name: String) {
        var product: Product = database.get(id: id)
        product.name = name
        database.set(product, id: id)
    }
}

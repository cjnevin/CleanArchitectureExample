//
//  EditProductUseCase.swift
//  Domain
//
//  Created by Chris on 04/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

struct EditProductUseCase<Product: ProductModel> {
    let id: String
    let database: Storable

    func edit(name: String) {
        var product: Product = database.get(id: id)
        product.name = name
        database.set(product, id: id)
    }
}

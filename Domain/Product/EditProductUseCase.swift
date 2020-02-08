//
//  EditProductUseCase.swift
//  Domain
//
//  Created by Chris on 04/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

struct EditProductUseCase<Product: AnyProduct> {
    let id: String
    let modelStorage: ModelStorage

    func edit(name: String) {
        var product: Product = modelStorage.get(id: id)
        product.name = name
        modelStorage.set(product, id: id)
    }
}

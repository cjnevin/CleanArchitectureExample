//
//  DeleteProductUseCase.swift
//  Domain
//
//  Created by Chris on 06/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

struct DeleteProductUseCase<Product: ProductModel> {
    let modelStorage: ModelStorage

    @discardableResult func delete(id: String) -> Product {
        modelStorage.delete(id: id)
    }
}

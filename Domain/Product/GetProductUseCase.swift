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
    let modelStorage: ModelStorage

    func get() -> Product {
        modelStorage.get(id: id)
    }
}

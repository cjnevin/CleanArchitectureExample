//
//  MockProductList.swift
//  DomainTests
//
//  Created by Chris on 06/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import Foundation

struct Product: AnyProduct {
    var id: String = "id"
    var name: String = "name"
}

class ProductListCoordinator: ProductListCoordinating {
    var dependencies: ProductListDependencies
    required init(dependencies: ProductListDependencies) {
        self.dependencies = dependencies
    }

    func view(for product: Product, database: AnyDatabase) -> ProductView {
        ProductView()
    }

    var spySelectedProduct: Bool = false
    func push(_ any: Any) {
        spySelectedProduct = true
    }
    func pop() { }
}

final class ProductListView: AnyProductListView {
    var productsUnavailable: Bool = false
    var products: [Product] = []
}

final class ProductView: AnyProductView {
    var spyProduct: Product?

    func setProduct(_ product: Product) {
        spyProduct = product
    }
}

class ProductCoordinator: ProductCoordinating {
    var spyReturnedToList: Bool = false

    func pop() {
        spyReturnedToList = true
    }
}

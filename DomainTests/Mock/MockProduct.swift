//
//  MockProductList.swift
//  DomainTests
//
//  Created by Chris on 06/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Common
import Domain

struct Product: AnyProduct {
    var id: String = "id"
    var name: String = "name"
}

class ProductListCoordinator: AnyProductListCoordinator {
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
    var presenter: ProductListPresenter<Product>?
    var productsUnavailable: Bool = false
    var sections: [Section<Product>] = []
}

final class ProductView: AnyProductView {
    var presenter: ProductPresenter<Product>?

    var spyProduct: Product?

    func setProduct(_ product: Product) {
        spyProduct = product
    }
}

class ProductCoordinator: AnyProductCoordinator {
    var spyReturnedToList: Bool = false

    func pop() {
        spyReturnedToList = true
    }
}

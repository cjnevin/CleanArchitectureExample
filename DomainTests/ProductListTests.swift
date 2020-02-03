//
//  ProductListTests.swift
//  DomainTests
//
//  Created by Chris Nevin on 3/2/20.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import Foundation
import XCTest

class ProductListTests: XCTestCase {
    var database: Database!
    var coordinator: ProductListCoordinator!
    var presenter: ProductListPresenter<ProductListView, ProductListCoordinator>!
    
    override func setUp() {
        super.setUp()
        database = Database()
        coordinator = ProductListCoordinator(database: database)
        presenter = ProductListPresenter(coordinator: coordinator)
    }
    
    func testAttachWhenEmpty() {
        let view = ProductListView()
        presenter.attach(view: view)
        XCTAssertTrue(view.products.isEmpty)
    }
    
    func testAttach() {
        database.lookup["id1"] = Product(id: "id1", name: "product 1")
        database.lookup["id2"] = Product(id: "id2", name: "product 2")
        database.lookup["id3"] = Product(id: "id3", name: "product 3")
        let view = ProductListView()
        presenter.attach(view: view)
        XCTAssertEqual(view.products.map { $0.id }, database.lookup.keys.sorted())
        presenter.detach()
    }
    
    func testSelectedProduct() {
        database.lookup["id"] = Product()
        let view = ProductListView()
        presenter.attach(view: view)
        XCTAssertFalse(view.products.isEmpty)
        presenter.selected(product: view.products[0])
        XCTAssertNotNil(coordinator.spySelectedProduct)
    }
}

struct Product: IProduct {
    var id: String = "id"
    var name: String = "name"
}

class ProductListCoordinator: IProductListCoordinator {
    func view(for product: Product, database: IDatabase) -> ProductView {
        ProductView()
    }

    required init(database: IDatabase) {
        self.database = database
    }

    var database: IDatabase

    typealias ProductView = DomainTests.ProductView

    typealias Product = DomainTests.Product

    var spySelectedProduct: Bool = false

    func push(_ any: Any) {
        spySelectedProduct = true
    }

    func pop() {

    }
}

final class ProductListView: IProductListView {
    var products: [Product] = []
}

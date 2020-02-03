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
        coordinator = ProductListCoordinator()
        presenter = ProductListPresenter(database: database, coordinator: coordinator)
    }
    
    func testAttachWhenEmpty() {
        let view = ProductListView()
        presenter.attach(view: view)
        XCTAssertTrue(view.spyProducts.isEmpty)
    }
    
    func testAttach() {
        database.lookup["id"] = Product()
        let view = ProductListView()
        presenter.attach(view: view)
        XCTAssertFalse(view.spyProducts.isEmpty)
        presenter.detach()
    }
    
    func testSelectedProduct() {
        database.lookup["id"] = Product()
        let view = ProductListView()
        presenter.attach(view: view)
        XCTAssertFalse(view.spyProducts.isEmpty)
        presenter.selected(product: view.spyProducts[0])
        XCTAssertNotNil(coordinator.spySelectedProduct)
    }
}

struct Product: IProduct {
    var id: String = "id"
}

class ProductListCoordinator: IProductListCoordinator {
    var spySelectedProduct: Product?
    
    func selectedProduct(_ product: Product) {
        spySelectedProduct = product
    }
}

final class ProductListView: IProductListView {
    var spyProducts: [Product] = []
    
    func setProducts(_ products: [Product]) {
        spyProducts = products
    }
}

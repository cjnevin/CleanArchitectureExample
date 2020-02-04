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
    var api: APIService!
    var database: Database!
    var coordinator: ProductListCoordinator!
    var presenter: ProductListPresenter<ProductListView, ProductListCoordinator>!
    
    override func setUp() {
        super.setUp()
        api = APIService()
        database = Database()
        coordinator = ProductListCoordinator(dependencies: Dependencies(api: api, database: database))
        presenter = ProductListPresenter(coordinator: coordinator)
    }

    func testAttachHitsApiForDataIfDatabaseIsEmptyThenFailsAndRetriesOnReattach() {
        api.success = false
        let view = ProductListView()
        presenter.attach(view: view)
        XCTAssertEqual(view.productsUnavailable, true)
        XCTAssertTrue(view.products.isEmpty)
        XCTAssertEqual(api.spyExecuteCount, 1)
        XCTAssertEqual(database.spyListCount, 1)
        presenter.detach()
        presenter.attach(view: view)
        XCTAssertEqual(api.spyExecuteCount, 2)
        XCTAssertEqual(database.spyListCount, 2)
    }

    func testAttachHitsApiForDataIfDatabaseIsEmptyThenDatabaseAfterApiReturns() {
        let apiProductIds = ["1", "2", "3", "4"]
        let view = ProductListView()
        presenter.attach(view: view)
        XCTAssertEqual(view.productsUnavailable, false)
        XCTAssertEqual(view.products.map { $0.id }, apiProductIds)
        XCTAssertEqual(api.spyExecuteCount, 1)
        XCTAssertEqual(database.spyListCount, 1)
        presenter.detach()
        presenter.attach(view: view)
        XCTAssertEqual(api.spyExecuteCount, 1)
        XCTAssertEqual(database.spyListCount, 2)
    }
    
    func testAttachHitsDatabaseForData() {
        database.lookup["id1"] = Product(id: "id1", name: "product 1")
        database.lookup["id2"] = Product(id: "id2", name: "product 2")
        database.lookup["id3"] = Product(id: "id3", name: "product 3")
        let view = ProductListView()
        presenter.attach(view: view)
        XCTAssertEqual(view.productsUnavailable, false)
        XCTAssertEqual(view.products.map { $0.id }, database.lookup.keys.sorted())
        presenter.detach()
        XCTAssertEqual(api.spyExecuteCount, 0)
        XCTAssertEqual(database.spyListCount, 1)
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
    var dependencies: ProductListDependencies
    required init(dependencies: ProductListDependencies) {
        self.dependencies = dependencies
    }

    func view(for product: Product, database: IDatabase) -> ProductView {
        ProductView()
    }

    var spySelectedProduct: Bool = false
    func push(_ any: Any) {
        spySelectedProduct = true
    }
    func pop() { }
}

final class ProductListView: IProductListView {
    var productsUnavailable: Bool = false
    var products: [Product] = []
}

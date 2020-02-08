//
//  ProductListPresenterTests.swift
//  DomainTests
//
//  Created by Chris Nevin on 3/2/20.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import Foundation
import XCTest

class ProductListPresenterTests: XCTestCase {
    var requestExecutor: MockRequestExecutor!
    var database: MockDatabase!
    var coordinator: ProductListCoordinator!
    var presenter: ProductListPresenter<ProductListView, ProductListCoordinator>!
    
    override func setUp() {
        super.setUp()
        requestExecutor = MockRequestExecutor()
        database = MockDatabase()
        coordinator = ProductListCoordinator(dependencies: MockDependencies(database: database, requestExecutor: requestExecutor))
        presenter = ProductListPresenter(coordinator: coordinator)
    }

    func testAttachSendsRequestForDataIfStorageIsEmptyThenFailsAndRetriesOnReattach() {
        requestExecutor.success = false
        let view = ProductListView()
        presenter.attach(view: view)
        XCTAssertEqual(view.productsUnavailable, true)
        XCTAssertTrue(view.products.isEmpty)
        XCTAssertEqual(requestExecutor.spyExecuteCount, 1)
        XCTAssertEqual(database.spyListCount, 1)
        presenter.detach()
        presenter.attach(view: view)
        XCTAssertEqual(requestExecutor.spyExecuteCount, 2)
        XCTAssertEqual(database.spyListCount, 2)
    }

    func testAttachSendsRequestForDataIfStorageIsEmptyThenStorageAfterRequestReturnsSuccessfully() {
        let apiProductIds = ["1", "2", "3", "4"]
        let view = ProductListView()
        presenter.attach(view: view)
        XCTAssertEqual(view.productsUnavailable, false)
        XCTAssertEqual(view.products.map { $0.id }, apiProductIds)
        XCTAssertEqual(requestExecutor.spyExecuteCount, 1)
        XCTAssertEqual(database.spyListCount, 1)
        presenter.detach()
        presenter.attach(view: view)
        XCTAssertEqual(requestExecutor.spyExecuteCount, 1)
        XCTAssertEqual(database.spyListCount, 2)
    }
    
    func testAttachHitsStorageForData() {
        database.lookup["id1"] = Product(id: "id1", name: "product 1")
        database.lookup["id2"] = Product(id: "id2", name: "product 2")
        database.lookup["id3"] = Product(id: "id3", name: "product 3")
        let view = ProductListView()
        presenter.attach(view: view)
        XCTAssertEqual(view.productsUnavailable, false)
        XCTAssertEqual(view.products.map { $0.id }, database.lookup.keys.sorted())
        presenter.detach()
        XCTAssertEqual(requestExecutor.spyExecuteCount, 0)
        XCTAssertEqual(database.spyListCount, 1)
    }

    func testDeletedProduct() {
        let view = ProductListView()
        presenter.attach(view: view)
        XCTAssertEqual(view.products.count, 4)
        presenter.deleted(product: view.products[0])
        XCTAssertEqual(database.spyDeleteCount, 1)
        XCTAssertEqual(view.products.count, 3)
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

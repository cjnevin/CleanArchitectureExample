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
    var api: MockRequestExecutor!
    var database: MockDatabase!
    var coordinator: ProductListCoordinator!
    var presenter: ProductListPresenter<ProductListView, ProductListCoordinator>!
    
    override func setUp() {
        super.setUp()
        api = MockRequestExecutor()
        database = MockDatabase()
        coordinator = ProductListCoordinator(dependencies: MockDependencies(api: api, database: database))
        presenter = ProductListPresenter(coordinator: coordinator)
    }

    func testAttachSendsRequestForDataIfStorageIsEmptyThenFailsAndRetriesOnReattach() {
        api.success = false
        let view = ProductListView()
        presenter.attach(view: view)
        XCTAssertEqual(view.productsUnavailable, true)
        XCTAssertTrue(view.sections.isEmpty)
        XCTAssertEqual(api.spyExecuteCount, 1)
        XCTAssertEqual(database.spyListCount, 1)
        presenter.detach()
        presenter.attach(view: view)
        XCTAssertEqual(api.spyExecuteCount, 2)
        XCTAssertEqual(database.spyListCount, 2)
    }

    func testAttachSendsRequestForDataIfStorageIsEmptyThenStorageAfterRequestReturnsSuccessfully() {
        let apiProductIds = ["1", "2", "3", "4"]
        let view = ProductListView()
        presenter.attach(view: view)
        XCTAssertEqual(view.productsUnavailable, false)
        XCTAssertEqual(view.sections.flatMap { $0.items.map { $0.id } }, apiProductIds)
        XCTAssertEqual(api.spyExecuteCount, 1)
        XCTAssertEqual(database.spyListCount, 1)
        presenter.detach()
        presenter.attach(view: view)
        XCTAssertEqual(api.spyExecuteCount, 1)
        XCTAssertEqual(database.spyListCount, 2)
    }
    
    func testAttachHitsStorageForData() {
        database.lookup["id1"] = Product(id: "id1", name: "product 1")
        database.lookup["id2"] = Product(id: "id2", name: "product 2")
        database.lookup["id3"] = Product(id: "id3", name: "product 3")
        let view = ProductListView()
        presenter.attach(view: view)
        XCTAssertEqual(view.productsUnavailable, false)
        XCTAssertEqual(view.sections.flatMap { $0.items.map { $0.id } }, database.lookup.keys.sorted())
        presenter.detach()
        XCTAssertEqual(api.spyExecuteCount, 0)
        XCTAssertEqual(database.spyListCount, 1)
    }

    func testDeletedProduct() {
        let view = ProductListView()
        presenter.attach(view: view)
        XCTAssertEqual(view.sections[0].items.count, 4)
        presenter.deleted(product: view.sections[0].items[0])
        XCTAssertEqual(database.spyDeleteCount, 1)
        XCTAssertEqual(view.sections[0].items.count, 3)
    }

    func testSelectedProduct() {
        database.lookup["id"] = Product()
        let view = ProductListView()
        presenter.attach(view: view)
        XCTAssertFalse(view.sections.isEmpty)
        presenter.selected(product: view.sections[0].items[0])
        XCTAssertNotNil(coordinator.spySelectedProduct)
    }

    func testSearchForProduct() {
        database.lookup["id1"] = Product(id: "id1", name: "nintendo switch")
        database.lookup["id2"] = Product(id: "id2", name: "nintendo ds")
        database.lookup["id3"] = Product(id: "id3", name: "ninja")
        let view = ProductListView()
        presenter.attach(view: view)
        XCTAssertFalse(view.sections.isEmpty)
        presenter.search(query: "nintendo")
        XCTAssertEqual(view.sections[0].items.map { $0.name }, ["nintendo ds", "nintendo switch"])
    }
}

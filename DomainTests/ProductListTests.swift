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
    var requestExecutor: MockRequestExecutor!
    var modelStorage: MockDatabase!
    var coordinator: ProductListCoordinator!
    var presenter: ProductListPresenter<ProductListView, ProductListCoordinator>!
    
    override func setUp() {
        super.setUp()
        requestExecutor = MockRequestExecutor()
        modelStorage = MockDatabase()
        coordinator = ProductListCoordinator(dependencies: MockDependencies(modelStorage: modelStorage, requestExecutor: requestExecutor))
        presenter = ProductListPresenter(coordinator: coordinator)
    }

    func testAttachSendsRequestForDataIfStorageIsEmptyThenFailsAndRetriesOnReattach() {
        requestExecutor.success = false
        let view = ProductListView()
        presenter.attach(view: view)
        XCTAssertEqual(view.productsUnavailable, true)
        XCTAssertTrue(view.products.isEmpty)
        XCTAssertEqual(requestExecutor.spyExecuteCount, 1)
        XCTAssertEqual(modelStorage.spyListCount, 1)
        presenter.detach()
        presenter.attach(view: view)
        XCTAssertEqual(requestExecutor.spyExecuteCount, 2)
        XCTAssertEqual(modelStorage.spyListCount, 2)
    }

    func testAttachSendsRequestForDataIfStorageIsEmptyThenStorageAfterRequestReturnsSuccessfully() {
        let apiProductIds = ["1", "2", "3", "4"]
        let view = ProductListView()
        presenter.attach(view: view)
        XCTAssertEqual(view.productsUnavailable, false)
        XCTAssertEqual(view.products.map { $0.id }, apiProductIds)
        XCTAssertEqual(requestExecutor.spyExecuteCount, 1)
        XCTAssertEqual(modelStorage.spyListCount, 1)
        presenter.detach()
        presenter.attach(view: view)
        XCTAssertEqual(requestExecutor.spyExecuteCount, 1)
        XCTAssertEqual(modelStorage.spyListCount, 2)
    }
    
    func testAttachHitsStorageForData() {
        modelStorage.lookup["id1"] = Product(id: "id1", name: "product 1")
        modelStorage.lookup["id2"] = Product(id: "id2", name: "product 2")
        modelStorage.lookup["id3"] = Product(id: "id3", name: "product 3")
        let view = ProductListView()
        presenter.attach(view: view)
        XCTAssertEqual(view.productsUnavailable, false)
        XCTAssertEqual(view.products.map { $0.id }, modelStorage.lookup.keys.sorted())
        presenter.detach()
        XCTAssertEqual(requestExecutor.spyExecuteCount, 0)
        XCTAssertEqual(modelStorage.spyListCount, 1)
    }
    
    func testSelectedProduct() {
        modelStorage.lookup["id"] = Product()
        let view = ProductListView()
        presenter.attach(view: view)
        XCTAssertFalse(view.products.isEmpty)
        presenter.selected(product: view.products[0])
        XCTAssertNotNil(coordinator.spySelectedProduct)
    }
}

struct Product: ProductModel {
    var id: String = "id"
    var name: String = "name"
}

class ProductListCoordinator: ProductListCoordinating {
    var dependencies: ProductListDependencies
    required init(dependencies: ProductListDependencies) {
        self.dependencies = dependencies
    }

    func view(for product: Product, modelStorage: ModelStorage) -> ProductView {
        ProductView()
    }

    var spySelectedProduct: Bool = false
    func push(_ any: Any) {
        spySelectedProduct = true
    }
    func pop() { }
}

final class ProductListView: ProductListViewing {
    var productsUnavailable: Bool = false
    var products: [Product] = []
}

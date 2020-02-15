//
//  ProductPresenterTests.swift
//  DomainTests
//
//  Created by Chris Nevin on 3/2/20.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import Foundation
import XCTest

class ProductPresenterTests: XCTestCase {
    var database: MockDatabase!
    var coordinator: ProductCoordinator!
    var presenter: ProductPresenter<Product>!
    
    override func setUp() {
        super.setUp()
        database = MockDatabase()
        database.lookup["id"] = Product()
        coordinator = ProductCoordinator()
        presenter = ProductPresenter(id: "id", database: database, coordinator: coordinator)
    }
    
    func testAttach() {
        let view = ProductView()
        presenter.attach(view: view)
        XCTAssertNotNil(view.spyProduct)
        presenter.detach()
        XCTAssertEqual(database.spyGetCount, 1)
    }

    func testSave() {
        let view = ProductView()
        presenter.attach(view: view)
        XCTAssertNotNil(view.spyProduct)
        XCTAssertEqual(database.spyGetCount, 1)

        XCTAssertEqual(database.spySetCount, 0)
        XCTAssertFalse(coordinator.spyReturnedToList)
        presenter.save(name: "new name")
        XCTAssertEqual(database.spySetCount, 1)
        XCTAssertTrue(coordinator.spyReturnedToList)

        let product: Product = database.get(id: "id")
        XCTAssertEqual(product.name, "new name")
    }
}

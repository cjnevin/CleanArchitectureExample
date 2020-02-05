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
    var modelStorage: MockDatabase!
    var coordinator: ProductCoordinator!
    var presenter: ProductPresenter<ProductView, ProductCoordinator>!
    
    override func setUp() {
        super.setUp()
        modelStorage = MockDatabase()
        modelStorage.lookup["id"] = Product()
        coordinator = ProductCoordinator()
        presenter = ProductPresenter(id: "id", modelStorage: modelStorage, coordinator: coordinator)
    }
    
    func testAttach() {
        let view = ProductView()
        presenter.attach(view: view)
        XCTAssertNotNil(view.spyProduct)
        presenter.detach()
        XCTAssertEqual(modelStorage.spyGetCount, 1)
    }

    func testSave() {
        let view = ProductView()
        presenter.attach(view: view)
        XCTAssertNotNil(view.spyProduct)
        XCTAssertEqual(modelStorage.spyGetCount, 1)

        XCTAssertEqual(modelStorage.spySetCount, 0)
        XCTAssertFalse(coordinator.spyReturnedToList)
        presenter.save(name: "new name")
        XCTAssertEqual(modelStorage.spySetCount, 1)
        XCTAssertTrue(coordinator.spyReturnedToList)

        let product: Product = modelStorage.get(id: "id")
        XCTAssertEqual(product.name, "new name")
    }
}

//
//  ProductTests.swift
//  DomainTests
//
//  Created by Chris Nevin on 3/2/20.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import Foundation
import XCTest

class ProductTests: XCTestCase {
    var database: Database!
    var coordinator: ProductCoordinator!
    var presenter: ProductPresenter<ProductView, ProductCoordinator>!
    
    override func setUp() {
        super.setUp()
        database = Database()
        database.lookup["id"] = Product()
        coordinator = ProductCoordinator()
        presenter = ProductPresenter(id: "id", database: database, coordinator: coordinator)
    }
    
    func testAttach() {
        let view = ProductView()
        presenter.attach(view: view)
        XCTAssertNotNil(view.spyProduct)
        presenter.detach()
    }

    func testSave() {
        let view = ProductView()
        presenter.attach(view: view)
        XCTAssertNotNil(view.spyProduct)

        XCTAssertFalse(coordinator.spyReturnedToList)
        presenter.save(name: "new name")
        XCTAssertTrue(coordinator.spyReturnedToList)

        let product: Product = database.get(id: "id")
        XCTAssertEqual(product.name, "new name")
    }
}

final class ProductView: IProductView {
    var spyProduct: Product?
    
    func setProduct(_ product: Product) {
        spyProduct = product
    }
}

class ProductCoordinator: IProductCoordinator {
    var spyReturnedToList: Bool = false

    func pop() {
        spyReturnedToList = true
    }
}

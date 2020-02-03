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
    var presenter: ProductPresenter<ProductView>!
    
    override func setUp() {
        super.setUp()
        database = Database()
        database.lookup["id"] = Product()
        presenter = ProductPresenter(id: "id", database: database)
    }
    
    func testAttach() {
        let view = ProductView()
        presenter.attach(view: view)
        XCTAssertNotNil(view.spyProduct)
        presenter.detach()
    }
}

final class ProductView: IProductView {
    var spyProduct: Product?
    
    func setProduct(_ product: Product) {
        spyProduct = product
    }
}

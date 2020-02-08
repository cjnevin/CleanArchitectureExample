//
//  ProductListCoordinating.swift
//  Domain
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 cjnevin. All rights reserved.
//

import Foundation

public typealias ProductListDependencies = DatabaseHaving & APIHaving

public protocol AnyProductListCoordinator: PushCoordinating, AnyProductCoordinator {
    associatedtype ProductView: AnyProductView
    associatedtype Product: AnyProduct
    init(dependencies: ProductListDependencies)
    var dependencies: ProductListDependencies { get }
    func view(for product: Product, database: AnyDatabase) -> ProductView
}

extension AnyProductListCoordinator {
    func selectedProduct(_ product: Product) {
        push(view(for: product, database: dependencies.database))
    }
}

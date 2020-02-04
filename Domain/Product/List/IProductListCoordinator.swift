//
//  IProductListCoordinator.swift
//  Domain
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 cjnevin. All rights reserved.
//

import Foundation

public protocol IProductListCoordinator: PushCoordinator, IProductCoordinator {
    associatedtype ProductView: IProductView
    associatedtype Product: IProduct
    init(dependencies: ProductListDependencies)
    var dependencies: ProductListDependencies { get }
    func view(for product: Product, database: IDatabase) -> ProductView
}

extension IProductListCoordinator {
    public typealias ProductListDependencies = APIServiceHaving & DatabaseHaving
    func selectedProduct(_ product: Product) {
        push(view(for: product, database: dependencies.database))
    }
}

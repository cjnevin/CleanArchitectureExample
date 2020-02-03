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
    init(database: IDatabase)
    var database: IDatabase { get }
    func view(for product: Product, database: IDatabase) -> ProductView
}

extension IProductListCoordinator {
    func selectedProduct(_ product: Product) {
        push(view(for: product, database: database))
    }
}

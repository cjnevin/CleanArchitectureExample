//
//  IProductListCoordinator.swift
//  Domain
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 cjnevin. All rights reserved.
//

import Foundation

public protocol IProductListCoordinator {
    associatedtype Product: IProduct
    func selectedProduct(_ product: Product)
}

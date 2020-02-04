//
//  ProductListViewing.swift
//  Domain
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 cjnevin. All rights reserved.
//

import Foundation

public protocol ProductListViewing: AnyObject {
    associatedtype Product: ProductModel
    var products: [Product] { get set }
    var productsUnavailable: Bool { get set }
}

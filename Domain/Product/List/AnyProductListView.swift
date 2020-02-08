//
//  ProductListViewing.swift
//  Domain
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 cjnevin. All rights reserved.
//

import Foundation

public protocol AnyProductListView: AnyObject {
    associatedtype Product: AnyProduct
    var sections: [Section<Product>] { get set }
    var productsUnavailable: Bool { get set }
}

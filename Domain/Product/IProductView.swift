//
//  IProductView.swift
//  Domain
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 cjnevin. All rights reserved.
//

import Foundation

public protocol IProductView {
    associatedtype Product: IProduct
    func setProduct(_ product: Product)
}

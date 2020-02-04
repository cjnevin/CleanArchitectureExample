//
//  ProductModel.swift
//  Domain
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 cjnevin. All rights reserved.
//

import Foundation

public protocol ProductModel: Comparable, Decodable {
    var id: String { get }
    var name: String { get set }
}

extension ProductModel where Self: Comparable {
    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.id < rhs.id
    }
}

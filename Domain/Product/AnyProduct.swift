//
//  ProductModel.swift
//  Domain
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 cjnevin. All rights reserved.
//

import Foundation

public protocol AnyProduct: Comparable, Decodable {
    var id: String { get }
    var name: String { get set }
}

extension AnyProduct where Self: Comparable {
    public static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name
    }

    public static func < (lhs: Self, rhs: Self) -> Bool {
        lhs.name < rhs.name
    }
}

extension Sequence where Element: AnyProduct {
    var sections: [Section<Element>] {
        Set(map { String($0.name.prefix(1)) })
            .sorted()
            .map { title in Section(name: title, items: filter { $0.name.hasPrefix(title) }.sorted()) }
    }
}

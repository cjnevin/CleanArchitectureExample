//
//  Section.swift
//  Domain
//
//  Created by Chris on 08/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

public struct Section<Item: Comparable>: Comparable {
    public static func == (lhs: Section<Item>, rhs: Section<Item>) -> Bool {
        lhs.name == rhs.name && lhs.items == rhs.items
    }
    public static func < (lhs: Section<Item>, rhs: Section<Item>) -> Bool {
        lhs.name < rhs.name
    }
    public let name: String
    public let items: [Item]

    public init(name: String, items: [Item]) {
        self.name = name
        self.items = items
    }
}

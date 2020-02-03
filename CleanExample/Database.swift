//
//  Database.swift
//  CleanExample
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import Foundation

class Database: IDatabase {
    var lookup: [String: Any] = [:]

    func get<Object>(id: String) -> Object {
        lookup[id] as! Object
    }

    func list<Object>() -> [Object] {
        lookup.values.compactMap { $0 as? Object }
    }

    func set<Object>(_ object: Object, id: String) {
        lookup[id] = object
    }
}

extension Database {
    static func make() -> Database {
        let db = Database()
        db.lookup["id1"] = Product(id: "id1", name: "Product 1")
        db.lookup["id2"] = Product(id: "id2", name: "Product 2")
        db.lookup["id3"] = Product(id: "id3", name: "Product 3")
        db.lookup["id4"] = Product(id: "id4", name: "Product 4")
        return db
    }
}

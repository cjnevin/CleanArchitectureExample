//
//  Database.swift
//  CleanExample
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import Foundation

class Database: AnyDatabase {
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

    func delete<Model>(id: String) -> Model {
        let object: Model = get(id: id)
        lookup.removeValue(forKey: id)
        return object
    }
}

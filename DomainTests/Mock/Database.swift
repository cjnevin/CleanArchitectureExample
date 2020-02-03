//
//  Database.swift
//  DomainTests
//
//  Created by Chris Nevin on 3/2/20.
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

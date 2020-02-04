//
//  MockDatabase.swift
//  DomainTests
//
//  Created by Chris Nevin on 3/2/20.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import Foundation

class MockDatabase: ModelStorage {
    var lookup: [String: Any] = [:]

    var spyGetCount: Int = 0
    var spyListCount: Int = 0
    var spySetCount: Int = 0

    func get<Object>(id: String) -> Object {
        spyGetCount += 1
        return lookup[id] as! Object
    }
    
    func list<Object>() -> [Object] {
        spyListCount += 1
        return lookup.values.compactMap { $0 as? Object }
    }

    func set<Object>(_ object: Object, id: String) {
        spySetCount += 1
        return lookup[id] = object
    }
}

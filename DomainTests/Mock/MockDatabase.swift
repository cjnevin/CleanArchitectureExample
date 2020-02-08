//
//  MockDatabase.swift
//  DomainTests
//
//  Created by Chris Nevin on 3/2/20.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Combine
import Domain
import Foundation

class MockDatabase: AnyDatabase {
    var lookup: [String: Any] = [:]

    var spyGetCount: Int = 0
    var spyListCount: Int = 0
    var spySetCount: Int = 0
    var spyDeleteCount: Int = 0
    var spyDropCount: Int = 0

    func get<Model>(id: String) -> Model {
        spyGetCount += 1
        return lookup[id] as! Model
    }
    
    func list<Model>() -> AnyPublisher<[Model], Error> {
        spyListCount += 1
        return Result.success(lookup.values.compactMap { $0 as? Model }).publisher.eraseToAnyPublisher()
    }

    func set<Model>(_ object: Model, id: String) {
        spySetCount += 1
        return lookup[id] = object
    }

    func delete<Model>(id: String) -> Model {
        spyDeleteCount += 1
        return lookup.removeValue(forKey: id)! as! Model
    }

    func drop<Model>(type: Model.Type) {
        spyDropCount += 1
        lookup = lookup.filter { !($0 is Model) }
    }
}

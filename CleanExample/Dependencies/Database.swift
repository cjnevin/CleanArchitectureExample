//
//  Database.swift
//  CleanExample
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Combine
import Common

class Database: AnyDatabase {
    var values = CurrentValueSubject<[String: Any], Error>([:])

    func get<Object>(id: String) -> Object {
        values.value[id] as! Object
    }

    func list<Object>() -> AnyPublisher<[Object], Error> {
        values.map { $0.values.compactMap { $0 as? Object } }.eraseToAnyPublisher()
    }

    func set<Object>(_ object: Object, id: String) {
        values.value[id] = object
    }

    func delete<Model>(id: String) -> Model {
        let object: Model = get(id: id)
        values.value.removeValue(forKey: id)
        return object
    }

    func drop<Model>(type: Model.Type) {
        values.value = values.value.filter { !($1 is Model) }
    }
}

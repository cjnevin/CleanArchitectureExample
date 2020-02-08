//
//  AnyDatabase.swift
//  Domain
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 cjnevin. All rights reserved.
//

import Foundation

public protocol AnyDatabase {
    func get<Model>(id: String) -> Model
    func list<Model>() -> [Model]
    func set<Model>(_ object: Model, id: String)
    func delete<Model>(id: String) -> Model
}

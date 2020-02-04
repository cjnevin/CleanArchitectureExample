//
//  Storable.swift
//  Domain
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 cjnevin. All rights reserved.
//

import Foundation

public protocol Storable {
    func get<Object>(id: String) -> Object
    func list<Object>() -> [Object]
    func set<Object>(_ object: Object, id: String)
}

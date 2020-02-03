//
//  MainCoordinator.swift
//  CleanExample
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import UIKit

class MainCoordinator {
    var database: IDatabase
    var window: UIWindow

    init(window: UIWindow) {
        self.window = window
        self.database = Database.make()
    }

    func start() {
        window.rootViewController = ProductListCoordinator(database: database)
        window.makeKeyAndVisible()
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

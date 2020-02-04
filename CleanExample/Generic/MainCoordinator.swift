//
//  MainCoordinator.swift
//  CleanExample
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import UIKit

class MainCoordinator: IMainCoordinator {
    typealias ProductListCoordinator = CleanExample.ProductListCoordinator

    var window: UIWindow!
    var database: IDatabase

    init(database: IDatabase) {
        self.database = database
    }

    func setRoot(_ any: Any) {
        window.rootViewController = any as? UIViewController
        window.makeKeyAndVisible()
    }
}

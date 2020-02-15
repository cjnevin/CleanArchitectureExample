//
//  RootCoordinator.swift
//  CleanExample
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Common
import UIKit

class RootCoordinator: AnyRootCoordinator {
    typealias TabCoordinator = CleanExample.TabCoordinator

    var window: UIWindow!
    var dependencies: AnyDependencies

    init(dependencies: AnyDependencies) {
        self.dependencies = dependencies
    }

    func setRoot(_ any: Any) {
        window.rootViewController = any as? UIViewController
        window.makeKeyAndVisible()
        (any as? TabCoordinator)?.start()
    }
}

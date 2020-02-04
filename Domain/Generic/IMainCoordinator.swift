//
//  IMainCoordinator.swift
//  Domain
//
//  Created by Chris on 04/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

public protocol IMainCoordinator {
    associatedtype ProductListCoordinator: IProductListCoordinator
    var dependencies: IDependencies { get }
    func start()
    func setRoot(_ any: Any)
}

public extension IMainCoordinator {
    func start() {
        setRoot(ProductListCoordinator(dependencies: dependencies))
    }
}

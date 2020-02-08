//
//  MapCoordinating.swift
//  Domain
//
//  Created by Chris on 08/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

public typealias MapDependencies = LocationServiceHaving

public protocol MapCoordinating {
    init(dependencies: MapDependencies)
    var dependencies: MapDependencies { get }
}

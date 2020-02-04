//
//  IDependencies.swift
//  Domain
//
//  Created by Chris on 04/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

public protocol APIServiceHaving {
    var api: IAPIService { get }
}

public protocol DatabaseHaving {
    var database: IDatabase { get }
}

public protocol IDependencies: APIServiceHaving, DatabaseHaving { }

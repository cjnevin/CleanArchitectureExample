//
//  Dependencies.swift
//  Domain
//
//  Created by Chris on 04/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

public protocol APIServiceHaving {
    var api: Requestable { get }
}

public protocol DatabaseHaving {
    var database: Storable { get }
}

public protocol Dependencies: APIServiceHaving, DatabaseHaving { }

//
//  AnyDependencies.swift
//  Domain
//
//  Created by Chris on 04/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

public protocol KeyValueStorageHaving {
    var keyValues: AnyKeyValueStorage { get }
}

public protocol DatabaseHaving {
    var database: AnyDatabase { get }
}

public protocol RequestExecutorHaving {
    var requestExecutor: AnyRequestExecutor { get }
}

public protocol AnyDependencies: DatabaseHaving, RequestExecutorHaving, KeyValueStorageHaving { }

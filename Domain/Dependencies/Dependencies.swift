//
//  Dependencies.swift
//  Domain
//
//  Created by Chris on 04/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

public protocol SettingStorageHaving {
    var settingStorage: SettingStorage { get }
}

public protocol ModelStorageHaving {
    var modelStorage: ModelStorage { get }
}

public protocol RequestExecutorHaving {
    var requestExecutor: RequestExecutor { get }
}

public protocol Dependencies: ModelStorageHaving, RequestExecutorHaving, SettingStorageHaving { }

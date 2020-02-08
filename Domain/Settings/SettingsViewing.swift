//
//  SettingsViewing.swift
//  Domain
//
//  Created by Chris on 06/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

public protocol SettingsViewing: AnyObject {
    associatedtype Item: Setting
    var settings: [Item] { get set }
}

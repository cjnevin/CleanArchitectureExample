//
//  SettingsViewing.swift
//  Domain
//
//  Created by Chris on 06/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

public protocol SettingsViewing: AnyObject {
    associatedtype Setting: AnySetting
    var settings: [Setting] { get set }
}

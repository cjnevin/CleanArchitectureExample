//
//  AnyNotificationsView.swift
//  Domain
//
//  Created by Chris on 08/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

public protocol AnyNotificationsView: AnyObject {
    var sections: [Section<Notification>] { get set }
}

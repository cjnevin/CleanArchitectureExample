//
//  DropNotificationsUseCase.swift
//  Domain
//
//  Created by Chris on 08/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

struct DropNotificationsUseCase {
    let database: AnyDatabase

    func drop() {
        database.drop(type: Notification.self)
    }
}

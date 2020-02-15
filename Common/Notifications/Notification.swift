//
//  Notification.swift
//  Domain
//
//  Created by Chris on 08/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

public struct Notification: Comparable {
    public static func < (lhs: Notification, rhs: Notification) -> Bool {
        lhs.date > rhs.date
    }
    public let date: Date
    public let title: String
    public let body: String

    public init(title: String, body: String) {
        self.date = Date()
        self.title = title
        self.body = body
    }
}

//
//  AnyNotificationService.swift
//  Domain
//
//  Created by Chris on 08/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Combine
import Foundation

public protocol AnyNotificationService {
    var notificationStatus: AnyPublisher<NotificationsStatus, Error> { get }
    func enableNotificationService()
    func disableNotificationService()
}

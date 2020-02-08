//
//  NotificationService.swift
//  CleanExample
//
//  Created by Chris on 08/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Combine
import Domain
import Foundation
import UserNotifications

class NotificationService: NSObject, AnyNotificationService, UNUserNotificationCenterDelegate {
    let notificationStatus: AnyPublisher<NotificationsStatus, Error>
    private var notifications = CurrentValueSubject<NotificationsStatus?, Error>(nil)
    private var running: Bool = false
    private var count: Int = 0

    override init() {
        notificationStatus = notifications.compactMap { $0 }.eraseToAnyPublisher()
        super.init()
        UNUserNotificationCenter.current().delegate = self
    }

    func enableNotificationService() {
        running = false
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .notDetermined {
                UNUserNotificationCenter.current().requestAuthorization(options: .alert) { enabled, _ in
                    if enabled {
                        self.setupTimer()
                    } else {
                        self.notifications.send(.disabled)
                    }
                }
            } else if settings.authorizationStatus == .authorized {
                self.setupTimer()
            } else {
                self.notifications.send(.disabled)
            }
        }
    }

    private func setupTimer() {
        func fire() {
            guard running else { return }
            count += 1
            let notificationContent = UNMutableNotificationContent()
            notificationContent.title = "Notification \(count)"
            notificationContent.body = UUID().uuidString

            let request = UNNotificationRequest(identifier: "notification_\(count)", content: notificationContent, trigger: nil)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)

            if running {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    fire()
                }
            }
        }
        running = true
        fire()
    }

    func disableNotificationService() {
        running = false
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        let content = notification.request.content
        notifications.send(.enabled(Notification(title: content.title, body: content.body)))
    }
}

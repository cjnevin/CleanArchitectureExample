//
//  NotificationsCoordinator.swift
//  CleanExample
//
//  Created by Chris on 08/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import UIKit

class NotificationsCoordinator: UINavigationController, AnyNotificationsCoordinator {
    let dependencies: NotificationsDependencies

    required init(dependencies: NotificationsDependencies) {
        self.dependencies = dependencies
        let viewController = NotificationsViewController()
        super.init(rootViewController: viewController)
        viewController.presenter = NotificationsPresenter(coordinator: self)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        tabBarItem = UITabBarItem(title: "Notifications", image: UIImage(systemName: "text.bubble"), tag: 3)
    }
}

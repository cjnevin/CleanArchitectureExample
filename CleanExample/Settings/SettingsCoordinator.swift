//
//  SettingsCoordinator.swift
//  CleanExample
//
//  Created by Chris on 06/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Common
import Domain
import UIKit

class SettingsCoordinator: UINavigationController, AnySettingsCoordinator {
    let dependencies: SettingsDependencies

    required init<TabCoordinator: AnyTabCoordinator>(dependencies: SettingsDependencies, tabCoordinator: TabCoordinator) {
        self.dependencies = dependencies
        let viewController = SettingsViewController()
        super.init(rootViewController: viewController)
        viewController.presenter = SettingsPresenter(coordinator: self, tabCoordinator: tabCoordinator as! CleanExample.TabCoordinator)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        tabBarItem = UITabBarItem(title: "Settings", image: UIImage(systemName: "gear"), tag: 1)
    }
}

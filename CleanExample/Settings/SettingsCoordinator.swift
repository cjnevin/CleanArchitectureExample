//
//  SettingsCoordinator.swift
//  CleanExample
//
//  Created by Chris on 06/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import UIKit

class SettingsCoordinator: UINavigationController, SettingsCoordinating {
    let dependencies: SettingsDependencies

    required init(dependencies: SettingsDependencies) {
        self.dependencies = dependencies
        let viewController = SettingsViewController()
        super.init(rootViewController: viewController)
        viewController.presenter = SettingsPresenter(coordinator: self)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        tabBarItem = UITabBarItem(tabBarSystemItem: .more, tag: 1)
    }
}

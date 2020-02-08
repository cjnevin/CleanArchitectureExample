//
//  MapCoordinator.swift
//  CleanExample
//
//  Created by Chris on 08/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import UIKit

class MapCoordinator: UINavigationController, AnyMapCoordinator {
    let dependencies: MapDependencies

    required init(dependencies: MapDependencies) {
        self.dependencies = dependencies
        let viewController = MapViewController()
        super.init(rootViewController: viewController)
        viewController.presenter = MapPresenter(coordinator: self)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        tabBarItem = UITabBarItem(title: "Location", image: UIImage(systemName: "map.fill"), tag: 2)
    }
}

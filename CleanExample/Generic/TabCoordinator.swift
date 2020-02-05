//
//  TabCoordinator.swift
//  CleanExample
//
//  Created by Chris on 05/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import UIKit

class TabCoordinator: UITabBarController, TabCoordinating {
    typealias ProductListCoordinator = CleanExample.ProductListCoordinator

    var dependencies: Dependencies
    required init(dependencies: Dependencies) {
        self.dependencies = dependencies
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addTab(_ any: Any) {
        var vcs = viewControllers ?? []
        vcs.append(any as! UIViewController)
        setViewControllers(vcs, animated: false)
    }

    func index<T>(of type: T.Type) -> Int? {
        viewControllers?.firstIndex(where: { $0 is T })
    }

    func showTab<T>(_ type: T.Type) {
        index(of: type).map { self.selectedIndex = $0 }
    }

    func removeTab<T>(_ type: T.Type) {
        index(of: type).map { tabIndex in
            var vcs = self.viewControllers ?? []
            vcs.remove(at: tabIndex)
            setViewControllers(vcs, animated: false)
        }
    }
}

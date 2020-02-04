//
//  PopCoordinator.swift
//  CleanExample
//
//  Created by Chris on 04/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import UIKit

extension PopCoordinator where Self: UINavigationController {
    func pop() {
        popViewController(animated: true)
    }
}

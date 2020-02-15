//
//  UINavigationController+Pop.swift
//  CleanExample
//
//  Created by Chris on 04/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Common
import UIKit

extension AnyPopCoordinator where Self: UINavigationController {
    func pop() {
        popViewController(animated: true)
    }
}

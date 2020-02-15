//
//  MakeProductItemUseCase.swift
//  Domain
//
//  Created by Chris on 08/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Common

struct MakeProductItemUseCase<Setting: AnySetting, TabCoordinator: AnyTabCoordinator> {
    let tabCoordinator: TabCoordinator

    func make(callback: @escaping () -> Void) -> Setting {
        tabCoordinator.hasProductList
            ? .init(key: "remove_product_list", value: .action({
                self.tabCoordinator.removeProductList()
                callback()
            }))
            : .init(key: "add_product_list", value: .action({
                self.tabCoordinator.insertProductList()
                callback()
            }))
    }
}

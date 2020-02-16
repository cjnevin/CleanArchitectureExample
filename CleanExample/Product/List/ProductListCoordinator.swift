//
//  ProductListCoordinator.swift
//  CleanExample
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Common
import Domain
import UIKit

class ProductListCoordinator: UINavigationController, AnyProductListCoordinator {
    let dependencies: ProductListDependencies

    required init(dependencies: ProductListDependencies) {
        self.dependencies = dependencies
        let viewController = ProductListViewController<ProductListPresenter<Product>>()
        super.init(rootViewController: viewController)
        viewController.presenter = ProductListPresenter(coordinator: self)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        tabBarItem = UITabBarItem(title: "Consoles", image: UIImage(systemName: "gamecontroller.fill"), tag: 0)
    }

    func view(for product: Product, database: AnyDatabase) -> ProductViewController<ProductPresenter<Product>> {
        let viewController = ProductViewController<ProductPresenter<Product>>()
        viewController.presenter = ProductPresenter<Product>(id: product.id, dependencies: dependencies, coordinator: self)
        return viewController
    }
}

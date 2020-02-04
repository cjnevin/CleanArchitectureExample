//
//  ProductListCoordinator.swift
//  CleanExample
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import UIKit

class ProductListCoordinator: UINavigationController, IProductListCoordinator, IProductCoordinator {
    let dependencies: ProductListDependencies

    required init(dependencies: ProductListDependencies) {
        self.dependencies = dependencies
        let viewController = ProductListViewController()
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
    }

    func view(for product: Product, database: IDatabase) -> ProductViewController {
        let viewController = ProductViewController()
        viewController.presenter = ProductPresenter<ProductViewController, ProductListCoordinator>(id: product.id, database: dependencies.database, coordinator: self)
        return viewController
    }
}
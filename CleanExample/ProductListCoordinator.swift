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
    let database: IDatabase

    required init(database: IDatabase) {
        self.database = database
        let viewController = ProductListViewController()
        super.init(rootViewController: viewController)
        viewController.presenter = ProductListPresenter(database: database, coordinator: self)
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
    }

    func selectedProduct(_ product: Product) {
        let viewController = ProductViewController()
        viewController.presenter = ProductPresenter(id: product.id, database: database, coordinator: self)
        pushViewController(viewController, animated: true)
    }

    func returnToList() {
        popViewController(animated: true)
    }
}

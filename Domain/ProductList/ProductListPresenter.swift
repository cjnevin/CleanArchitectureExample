//
//  ProductListPresenter.swift
//  Domain
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 cjnevin. All rights reserved.
//

import Foundation

public class ProductListPresenter<View: IProductListView, Coordinator: IProductListCoordinator>: IPresenter where Coordinator.Product == View.Product {
    let useCase: GetProductListUseCase<View.Product>
    let coordinator: Coordinator

    public init(database: IDatabase, coordinator: Coordinator) {
        self.useCase = GetProductListUseCase(database: database)
        self.coordinator = coordinator
    }

    public func attach(view: View) {
        view.products = useCase.list()
    }

    public func selected(product: View.Product) {
        coordinator.selectedProduct(product)
    }

    public func detach() {
        
    }
}

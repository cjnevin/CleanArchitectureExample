//
//  ProductListPresenter.swift
//  Domain
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 cjnevin. All rights reserved.
//

import Combine
import Foundation

public class ProductListPresenter<View: IProductListView, Coordinator: IProductListCoordinator>: IPresenter where Coordinator.Product == View.Product {
    var listStream: AnyCancellable?
    let useCase: GetProductListUseCase<View.Product>
    let coordinator: Coordinator

    public init(coordinator: Coordinator) {
        self.useCase = GetProductListUseCase(api: coordinator.dependencies.api, database: coordinator.dependencies.database)
        self.coordinator = coordinator
    }

    public func attach(view: View) {
        view.productsUnavailable = false
        view.products = []
        listStream?.cancel()
        listStream = useCase.list()
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure:
                    view.productsUnavailable = true
                }
            }, receiveValue: { products in
                view.products = products
            })
    }

    public func detach() {
        listStream?.cancel()
        listStream = nil
    }

    public func selected(product: View.Product) {
        coordinator.selectedProduct(product)
    }
}

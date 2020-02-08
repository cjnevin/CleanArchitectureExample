//
//  ProductListPresenter.swift
//  Domain
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 cjnevin. All rights reserved.
//

import Combine
import Foundation

public class ProductListPresenter<View: AnyProductListView, Coordinator: ProductListCoordinating>: Presenting where Coordinator.Product == View.Product {
    let refreshTrigger = PassthroughSubject<Void, Error>()
    var listStream: AnyCancellable?
    let deleteUseCase: DeleteProductUseCase<View.Product>
    let listUseCase: GetProductListUseCase<View.Product>
    let coordinator: Coordinator

    public init(coordinator: Coordinator) {
        self.deleteUseCase = DeleteProductUseCase(database: coordinator.dependencies.database)
        self.listUseCase = GetProductListUseCase(dependencies: coordinator.dependencies)
        self.coordinator = coordinator
    }

    public func attach(view: View) {
        view.productsUnavailable = false
        view.products = []
        listStream?.cancel()
        listStream = refreshTrigger
            .flatMap(listUseCase.list)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure:
                    view.productsUnavailable = true
                }
            }, receiveValue: { products in
                view.products = products
            })
        refreshTrigger.send(())
    }

    public func detach() {
        listStream?.cancel()
        listStream = nil
    }

    public func deleted(product: View.Product) {
        deleteUseCase.delete(id: product.id)
        refreshTrigger.send(())
    }

    public func selected(product: View.Product) {
        coordinator.selectedProduct(product)
    }
}

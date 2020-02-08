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
    let searchTrigger = PassthroughSubject<String, Error>()
    var listStream: AnyCancellable?
    let deleteUseCase: DeleteProductUseCase<View.Product>
    let searchUseCase: SearchProductListUseCase<View.Product>
    let coordinator: Coordinator

    public init(coordinator: Coordinator) {
        self.deleteUseCase = DeleteProductUseCase(database: coordinator.dependencies.database)
        self.searchUseCase = SearchProductListUseCase(listUseCase: GetProductListUseCase(dependencies: coordinator.dependencies))
        self.coordinator = coordinator
    }

    public func attach(view: View) {
        view.productsUnavailable = false
        view.sections = []
        listStream?.cancel()
        listStream = searchTrigger
            .combineLatest(refreshTrigger)
            .a
            .flatMap(searchUseCase.search)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .finished: break
                case .failure:
                    view.productsUnavailable = true
                }
            }, receiveValue: { products in
                view.sections = Set(products.map { String($0.name.prefix(1)) })
                    .sorted()
                    .map { title in
                        Section(name: title, items: products.filter { $0.name.hasPrefix(title) }.sorted())
                    }
            })
        refreshTrigger.send(())
        searchTrigger.send("")
    }

    public func detach() {
        listStream?.cancel()
        listStream = nil
    }

    public func search(query: String) {
        searchTrigger.send(query)
    }

    public func deleted(product: View.Product) {
        deleteUseCase.delete(id: product.id)
        refreshTrigger.send(())
    }

    public func selected(product: View.Product) {
        coordinator.selectedProduct(product)
    }
}

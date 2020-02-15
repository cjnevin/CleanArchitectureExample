//
//  ProductPresenter.swift
//  Domain
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 cjnevin. All rights reserved.
//

import Common

public struct ProductPresenter<Product: AnyProduct>: AnyProductPresenter {
    let pop: () -> Void
    let getUseCase: GetProductUseCase<Product>
    let editUseCase: EditProductUseCase<Product>

    public init<Coordinator: AnyProductCoordinator>(id: String, database: AnyDatabase, coordinator: Coordinator) {
        self.pop = coordinator.pop
        self.getUseCase = GetProductUseCase(id: id, database: database)
        self.editUseCase = EditProductUseCase(id: id, database: database)
    }

    public func attach<View: AnyProductView>(view: View) where View.Presenter.Product == Product {
        view.setProduct(getUseCase.get())
    }

    public func detach() {
        
    }

    public func save(name: String) {
        editUseCase.edit(name: name)
        pop()
    }
}

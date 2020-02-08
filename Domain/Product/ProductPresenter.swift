//
//  ProductPresenter.swift
//  Domain
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 cjnevin. All rights reserved.
//

import Foundation

public struct ProductPresenter<View: AnyProductView, Coordinator: ProductCoordinating>: Presenting {
    let coordinator: Coordinator
    let getUseCase: GetProductUseCase<View.Product>
    let editUseCase: EditProductUseCase<View.Product>

    public init(id: String, database: AnyDatabase, coordinator: Coordinator) {
        self.coordinator = coordinator
        self.getUseCase = GetProductUseCase(id: id, database: database)
        self.editUseCase = EditProductUseCase(id: id, database: database)
    }

    public func attach(view: View) {
        view.setProduct(getUseCase.get())
    }

    public func detach() {
        
    }

    public func save(name: String) {
        editUseCase.edit(name: name)
        coordinator.pop()
    }
}

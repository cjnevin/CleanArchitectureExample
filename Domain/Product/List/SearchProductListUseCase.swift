//
//  SearchProductListUseCase.swift
//  Domain
//
//  Created by Chris on 08/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Combine
import Common

struct SearchProductListUseCase<Product: AnyProduct> {
    let listUseCase: GetProductListUseCase<Product>

    func search(query: String) -> AnyPublisher<[Product], Error> {
        listUseCase.list().map { products in
            query.isEmpty ? products : products.filter { $0.name.localizedCaseInsensitiveContains(query) }
        }.eraseToAnyPublisher()
    }
}

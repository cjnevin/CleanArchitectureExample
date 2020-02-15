//
//  GetProductListUseCase.swift
//  Domain
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 cjnevin. All rights reserved.
//

import Combine
import Common

struct GetProductListUseCase<Product: AnyProduct> {
    let dependencies: DatabaseHaving & APIHaving

    func list() -> AnyPublisher<[Product], Error> {
        dependencies.database.list().flatMap { (items: [Product]) -> AnyPublisher<[Product], Error> in
            if items.isEmpty {
                return self.dependencies.api.fetchProducts(into: self.dependencies.database)
            } else {
                return Result.success(items.sorted()).publisher.eraseToAnyPublisher()
            }
        }.eraseToAnyPublisher()
    }
}

private extension AnyAPI {
    func fetchProducts<Product: AnyProduct>(into database: AnyDatabase) -> AnyPublisher<[Product], Error> {
        let url = URL(string: "https://example.com/products")!
        let request = URLRequest(url: url)
        let decoder = JSONDecoder()
        let result = execute(request: request)
            .tryMap { data -> [Product] in
                let products = try decoder.decode([Product].self, from: data)
                products.forEach {
                    database.set($0, id: $0.id)
                }
                return products.sorted()
            }
        return AnyPublisher(result)
    }
}

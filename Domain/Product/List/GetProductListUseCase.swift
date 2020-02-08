//
//  GetProductListUseCase.swift
//  Domain
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 cjnevin. All rights reserved.
//

import Combine
import Foundation

struct GetProductListUseCase<Product: AnyProduct> {
    let dependencies: DatabaseHaving & APIHaving

    func list() -> AnyPublisher<[Product], Error> {
        let products: [Product] = dependencies.database.list().sorted()
        guard products.isEmpty else {
            return AnyPublisher(Result<[Product], Error>.success(products).publisher)
        }
        return dependencies.api.fetchProducts(into: dependencies.database)
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

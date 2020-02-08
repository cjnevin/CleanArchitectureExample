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
    let dependencies: ModelStorageHaving & RequestExecutorHaving

    func list() -> AnyPublisher<[Product], Error> {
        let products: [Product] = dependencies.modelStorage.list().sorted()
        guard products.isEmpty else {
            return AnyPublisher(Result<[Product], Error>.success(products).publisher)
        }
        let url = URL(string: "https://example.com/products")!
        let request = URLRequest(url: url)
        let decoder = JSONDecoder()
        let result = dependencies.requestExecutor
            .execute(request: request)
            .tryMap { data -> [Product] in
                let products = try decoder.decode([Product].self, from: data)
                products.forEach {
                    self.dependencies.modelStorage.set($0, id: $0.id)
                }
                return products.sorted()
            }
        return AnyPublisher(result)
    }
}

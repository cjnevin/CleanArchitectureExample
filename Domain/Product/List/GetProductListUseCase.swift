//
//  GetProductListUseCase.swift
//  Domain
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 cjnevin. All rights reserved.
//

import Combine
import Foundation

struct GetProductListUseCase<Product: ProductModel> {
    let api: Requestable
    let database: Storable

    func list() -> AnyPublisher<[Product], Error> {
        let products: [Product] = database.list().sorted()
        guard products.isEmpty else {
            return AnyPublisher(Result<[Product], Error>.success(products).publisher)
        }
        let url = URL(string: "https://example.com/products")!
        let request = URLRequest(url: url)
        let decoder = JSONDecoder()
        let result = api
            .execute(request: request)
            .tryMap { data -> [Product] in
                let products = try decoder.decode([Product].self, from: data)
                products.forEach {
                    self.database.set($0, id: $0.id)
                }
                return products.sorted()
            }
        return AnyPublisher(result)
    }
}

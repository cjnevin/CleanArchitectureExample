//
//  API.swift
//  CleanExample
//
//  Created by Chris on 04/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Combine
import Domain
import Foundation

class API: AnyAPI {
    func execute(request: URLRequest) -> AnyPublisher<Data, Error> {
        let exampleResponse = """
[
    {
        "id": "1",
        "name": "Product 1"
    },
    {
        "id": "2",
        "name": "Product 2"
    },
    {
        "id": "3",
        "name": "Product 3"
    },
    {
        "id": "4",
        "name": "Product 4"
    }
]
"""
        let exampleData = exampleResponse.data(using: .utf8)!
        let result = Result<Data, Error>
            .success(exampleData)
            .publisher
            .subscribe(on: DispatchQueue.global(qos: .background))
            .receive(on: RunLoop.main)

        return AnyPublisher(result)
    }
}

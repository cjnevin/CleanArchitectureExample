//
//  RequestExecutor.swift
//  Domain
//
//  Created by Chris on 04/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Combine
import Foundation

public protocol AnyAPI {
    func execute(request: URLRequest) -> AnyPublisher<Data, Error>
}

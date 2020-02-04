//
//  Product.swift
//  CleanExample
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import Foundation

struct Product: IProduct, Decodable {
    let id: String
    var name: String
}

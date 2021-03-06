//
//  Product.swift
//  CleanExample
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Common
import Foundation

// This example object looks like a Realm one by using dynamic dispatch to prove the concept is sound.
class Product: AnyProduct, Decodable {
    dynamic var id: String
    dynamic var name: String
}

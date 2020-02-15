//
//  ProductListViewing.swift
//  Domain
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 cjnevin. All rights reserved.
//

import Foundation

public protocol AnyProductListView: AnyObject {
    associatedtype Presenter: AnyProductListPresenter
    var presenter: Presenter? { get set }
    var sections: [Section<Presenter.Product>] { get set }
    var productsUnavailable: Bool { get set }
}

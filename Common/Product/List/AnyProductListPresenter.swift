//
//  AnyProductListPresenter.swift
//  Common
//
//  Created by Chris on 16/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

public protocol AnyProductListPresenter {
    associatedtype Product: AnyProduct
    func attach<View: AnyProductListView>(view: View) where View.Presenter.Product == Product
    func detach()
    func search(query: String)
    func deleted(product: Product)
    func selected(product: Product)
}

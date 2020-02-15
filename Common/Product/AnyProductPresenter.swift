//
//  AnyProductPresenter.swift
//  Common
//
//  Created by Chris on 15/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

public protocol AnyProductPresenter {
    associatedtype Product: AnyProduct
    func attach<View: AnyProductView>(view: View) where View.Presenter.Product == Product
    func detach()
    func save(name: String)
}

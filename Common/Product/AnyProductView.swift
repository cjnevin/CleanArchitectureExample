//
//  AnyProductView.swift
//  Domain
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 cjnevin. All rights reserved.
//

import Foundation

public protocol AnyProductView {
    associatedtype Presenter: AnyProductPresenter
    var presenter: Presenter? { get set }
    func setProduct(_ product: Presenter.Product)
}

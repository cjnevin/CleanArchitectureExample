//
//  AnyView.swift
//  Common
//
//  Created by Chris on 15/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

public protocol AnyView: AnyObject {
    associatedtype Presenter: AnyPresenter
    var presenter: Presenter? { get set }
}

extension AnyView where Presenter.View == Self {
    public func attach() {
        presenter?.attach(view: self)
    }

    public func detach() {
        presenter?.detach()
    }
}

//
//  ProductViewController.swift
//  CleanExample
//
//  Created by Chris on 03/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import UIKit

class ProductViewController: UIViewController, ProductViewing {
    let textField = UITextField()
    var presenter: ProductPresenter<ProductViewController, ProductListCoordinator>?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        textField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(textField)
        textField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        textField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20).isActive = true
        textField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.attach(view: self)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter?.detach()
    }

    func setProduct(_ product: Product) {
        navigationItem.title = product.id
        textField.text = product.name
    }

    @objc private func save() {
        presenter?.save(name: textField.text ?? "")
    }
}

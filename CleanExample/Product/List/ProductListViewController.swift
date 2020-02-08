//
//  ViewController.swift
//  CleanExample
//
//  Created by Chris Nevin on 3/2/20.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import UIKit

class ProductListViewController: UITableViewController, AnyProductListView {
    let searchController = UISearchController(searchResultsController: nil)
    var presenter: ProductListPresenter<ProductListViewController, ProductListCoordinator>?

    var productsUnavailable: Bool = false {
        didSet {
            // Show some error?
        }
    }

    var sections: [Section<Product>] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "Consoles"
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Consoles"
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.attach(view: self)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        presenter?.detach()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        sections.map { $0.name }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell")
            ?? UITableViewCell(style: .default, reuseIdentifier: "ProductCell")
        cell.textLabel?.text = sections[indexPath.section].items[indexPath.row].name
        cell.accessoryType = .disclosureIndicator
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            // handle delete (by removing the data from your array and updating the tableview)
            presenter?.deleted(product: sections[indexPath.section].items[indexPath.row])
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.selected(product: sections[indexPath.section].items[indexPath.row])
    }
}

extension ProductListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        presenter?.search(query: searchController.searchBar.text ?? "")
    }
}

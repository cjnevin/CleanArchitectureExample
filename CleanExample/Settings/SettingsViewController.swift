//
//  SettingsViewController.swift
//  CleanExample
//
//  Created by Chris on 06/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import UIKit

class SettingsViewController: UITableViewController, SettingsViewing {
    var presenter: SettingsPresenter<SettingsViewController, SettingsCoordinator>?

    var items: [SettingItem] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    var settings: SettingsModel? {
        didSet {
            guard var settings = settings else {
                items = []
                return
            }
            func item(_ setting: Setting<Bool>, name: String, toggled: @escaping () -> SettingsModel) -> SettingItem {
                SettingItem(setting.key, name: name, value: .onOff(setting.value, toggle: {
                    self.presenter?.save(settings: toggled())
                }))
            }

            items = [
                item(settings.location, name: "Enable Location") {
                    settings.location.value.toggle()
                    return settings
                },
                item(settings.notifications, name: "Enable Notifications") {
                    settings.notifications.value.toggle()
                    return settings
                }
            ]
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.title = "Settings"
        tableView.register(SettingsToggleCell.self, forCellReuseIdentifier: "SettingsToggleCell")
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
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        settings == nil ? 0 : 2
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch items[indexPath.row].value {
        case let .onOff(isOn, toggle):
            let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsToggleCell", for: indexPath) as! SettingsToggleCell
            cell.bind(name: items[indexPath.row].name, isOn: isOn, toggle: toggle)
            return cell
        }
    }
}

class SettingsToggleCell: UITableViewCell {
    private var toggle: (() -> Void)?

    func bind(name: String, isOn: Bool, toggle: @escaping () -> Void) {
        let onOff = UISwitch()
        self.toggle = toggle
        onOff.isOn = isOn
        onOff.addTarget(self, action: #selector(toggled), for: .valueChanged)
        accessoryView = onOff
        textLabel?.text = name
        selectionStyle = .none
    }

    @objc private func toggled() {
        toggle?()
    }
}

struct SettingItem {
    enum Value {
        case onOff(Bool, toggle: () -> Void)
    }

    let key: String
    let name: String
    let value: Value

    init(_ key: String, name: String, value: Value) {
        self.key = key
        self.name = name
        self.value = value
    }
}

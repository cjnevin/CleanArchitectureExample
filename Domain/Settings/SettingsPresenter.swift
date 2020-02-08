//
//  SettingsPresenter.swift
//  Domain
//
//  Created by Chris on 06/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

public class SettingsPresenter<View: AnySettingsView, Coordinator: SettingsCoordinating, TabCoordinator: TabCoordinating>: Presenting {
    let coordinator: Coordinator
    let tabCoordinator: TabCoordinator
    let getSettingsUseCase: GetSettingsUseCase
    let editSettingsUseCase: EditSettingsUseCase
    var onDetach: (() -> Void)?

    public init(coordinator: Coordinator, tabCoordinator: TabCoordinator) {
        self.coordinator = coordinator
        self.tabCoordinator = tabCoordinator
        self.getSettingsUseCase = GetSettingsUseCase(keyValues: coordinator.dependencies.keyValues)
        self.editSettingsUseCase = EditSettingsUseCase(keyValues: coordinator.dependencies.keyValues)
    }

    public func attach(view: View) {
        func makeProductItem(_ callback: @escaping () -> Void) -> View.Setting {
            tabCoordinator.hasProductList
                ? .init(key: "remove_product_list", value: .action({
                    self.tabCoordinator.removeProductList()
                    callback()
                }))
                : .init(key: "add_product_list", value: .action({
                    self.tabCoordinator.addProductList()
                    callback()
                }))
        }

        func refresh(settings: StoredSettings) {
            var copy = settings
            view.settings = [
                .init(key: copy.notifications.key, value: .onOff(settings.notifications.value, toggle: {
                    copy.notifications.value.toggle()
                    self.save(settings: copy)
                })),
                .init(key: copy.location.key, value: .onOff(settings.location.value, toggle: {
                    copy.location.value.toggle()
                    self.save(settings: copy)
                })),
                makeProductItem {
                    refresh(settings: copy)
                }
            ]
        }
        refresh(settings: getSettingsUseCase.get())
        onDetach = { view.settings = [] }
    }

    public func detach() {
        onDetach?()
    }

    private func save(settings: StoredSettings) {
        editSettingsUseCase.edit(settings: settings)
    }
}

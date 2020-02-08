//
//  SettingsPresenter.swift
//  Domain
//
//  Created by Chris on 06/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Combine
import Foundation

public class SettingsPresenter<View: AnySettingsView, Coordinator: SettingsCoordinating, TabCoordinator: AnyTabCoordinator>: AnyPresenter {
    let coordinator: Coordinator
    let tabCoordinator: TabCoordinator
    let getSettingsUseCase: GetSettingsUseCase
    let editSettingsUseCase: EditSettingsUseCase
    let toggleLocationUseCase: ToggleLocationUseCase
    let toggleNotificationsUseCase: ToggleNotificationsUseCase<TabCoordinator>
    let makeProductItemUseCase: MakeProductItemUseCase<View.Setting, TabCoordinator>
    var onDetach: (() -> Void)?
    
    public init(coordinator: Coordinator, tabCoordinator: TabCoordinator) {
        self.coordinator = coordinator
        self.tabCoordinator = tabCoordinator
        self.getSettingsUseCase = GetSettingsUseCase(keyValues: coordinator.dependencies.keyValues)
        self.editSettingsUseCase = EditSettingsUseCase(keyValues: coordinator.dependencies.keyValues)
        self.toggleLocationUseCase = ToggleLocationUseCase(dependencies: coordinator.dependencies)
        self.toggleNotificationsUseCase = ToggleNotificationsUseCase(dependencies: coordinator.dependencies, tabCoordinator: tabCoordinator)
        self.makeProductItemUseCase = MakeProductItemUseCase(tabCoordinator: tabCoordinator)
    }

    public func attach(view: View) {
        func refresh(settings: StoredSettings) {
            var copy = settings
            view.settings = [
                .init(key: copy.notifications.key, value: .onOff(settings.notifications.value, toggle: {
                    copy.notifications.value.toggle()
                    self.editSettingsUseCase.edit(settings: copy)
                    self.toggleNotificationsUseCase.toggle(on: copy.notifications.value)
                })),
                .init(key: copy.location.key, value: .onOff(settings.location.value, toggle: {
                    copy.location.value.toggle()
                    self.editSettingsUseCase.edit(settings: copy)
                    self.toggleLocationUseCase.toggle(on: copy.location.value)
                })),
                makeProductItemUseCase.make {
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
}

//
//  SettingsPresenter.swift
//  Domain
//
//  Created by Chris on 06/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

public class SettingsPresenter<View: AnySettingsView, Coordinator: SettingsCoordinating>: Presenting {
    let coordinator: Coordinator
    let getSettingsUseCase: GetSettingsUseCase
    let editSettingsUseCase: EditSettingsUseCase
    var onDetach: (() -> Void)?

    public init(coordinator: Coordinator) {
        self.coordinator = coordinator
        self.getSettingsUseCase = GetSettingsUseCase(keyValues: coordinator.dependencies.keyValues)
        self.editSettingsUseCase = EditSettingsUseCase(keyValues: coordinator.dependencies.keyValues)
    }

    public func attach(view: View) {
        var settings = getSettingsUseCase.get()
        view.settings = [
            .init(key: settings.notifications.key, value: .onOff(settings.notifications.value, toggle: {
                settings.notifications.value.toggle()
                self.save(settings: settings)
            })),
            .init(key: settings.location.key, value: .onOff(settings.location.value, toggle: {
                settings.location.value.toggle()
                self.save(settings: settings)
            }))
        ]
        onDetach = { view.settings = [] }
    }

    public func detach() {
        onDetach?()
    }

    private func save(settings: StoredSettings) {
        editSettingsUseCase.edit(settings: settings)
    }
}

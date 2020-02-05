//
//  SettingsPresenter.swift
//  Domain
//
//  Created by Chris on 06/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Foundation

public class SettingsPresenter<View: SettingsViewing, Coordinator: SettingsCoordinating>: Presenting {
    let coordinator: Coordinator
    let getSettingsUseCase: GetSettingsUseCase
    let editSettingsUseCase: EditSettingsUseCase

    public init(coordinator: Coordinator) {
        self.coordinator = coordinator
        self.getSettingsUseCase = GetSettingsUseCase(settingStorage: coordinator.dependencies.settingStorage)
        self.editSettingsUseCase = EditSettingsUseCase(settingStorage: coordinator.dependencies.settingStorage)
    }

    public func attach(view: View) {
        view.settings = getSettingsUseCase.get()
    }

    public func detach() {

    }

    public func save(settings: SettingsModel) {
        editSettingsUseCase.edit(settings: settings)
    }
}

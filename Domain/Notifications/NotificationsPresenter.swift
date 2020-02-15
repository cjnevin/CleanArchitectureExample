//
//  NotificationsPresenter.swift
//  Domain
//
//  Created by Chris on 08/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Combine
import Common

public class NotificationsPresenter<View: AnyNotificationsView, Coordinator: AnyNotificationsCoordinator>: AnyPresenter {
    let getUseCase: GetNotificationsUseCase
    let dropUseCase: DropNotificationsUseCase
    var listCancellable: AnyCancellable?
    var onDetach: (() -> Void)?

    public init(coordinator: Coordinator) {
        self.getUseCase = GetNotificationsUseCase(database: coordinator.dependencies.database)
        self.dropUseCase = DropNotificationsUseCase(database: coordinator.dependencies.database)
    }

    public func attach(view: View) {
        listCancellable?.cancel()
        listCancellable = getUseCase.list().sink(
            receiveCompletion: { _ in },
            receiveValue: { notifications in
                view.sections = [Section(name: "", items: notifications)]
        })
    }

    public func clear() {
        dropUseCase.drop()
    }

    public func detach() {
        listCancellable?.cancel()
        listCancellable = nil
    }
}

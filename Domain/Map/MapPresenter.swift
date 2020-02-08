//
//  MapPresenter.swift
//  Domain
//
//  Created by Chris on 08/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Combine
import Foundation

public class MapPresenter<View: AnyMapView, Coordinator: AnyMapCoordinator>: AnyPresenter {
    let updatedLocationUseCase: UpdatedLocationUseCase
    var locationCancellable: AnyCancellable?
    var onDetach: (() -> Void)?

    public init(coordinator: Coordinator) {
        self.updatedLocationUseCase = UpdatedLocationUseCase(location: coordinator.dependencies.location)
    }

    public func attach(view: View) {
        locationCancellable?.cancel()
        locationCancellable = updatedLocationUseCase.watch().sink(
            receiveCompletion: { _ in },
            receiveValue: view.updated)
    }
    
    public func detach() {
        locationCancellable?.cancel()
        locationCancellable = nil
    }
}

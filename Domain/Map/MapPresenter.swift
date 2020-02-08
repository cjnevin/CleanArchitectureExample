//
//  MapPresenter.swift
//  Domain
//
//  Created by Chris on 08/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Combine
import Foundation

public class MapPresenter<View: AnyMapView, Coordinator: MapCoordinating>: Presenting {
    let coordinator: Coordinator
    var locationCancellable: AnyCancellable?
    var onDetach: (() -> Void)?

    public init(coordinator: Coordinator) {
        self.coordinator = coordinator
    }

    public func attach(view: View) {
        locationCancellable?.cancel()
        locationCancellable = coordinator.dependencies.location.locationStatus.sink(receiveCompletion: { _ in

        }, receiveValue: { status in
            if case .enabled(let location) = status {
                view.updated(location: location)
            }
        })
    }

    public func detach() {
        locationCancellable?.cancel()
        locationCancellable = nil
    }
}

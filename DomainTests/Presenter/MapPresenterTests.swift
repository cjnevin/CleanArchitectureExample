//
//  MapPresenterTests.swift
//  DomainTests
//
//  Created by Chris on 08/02/2020.
//  Copyright © 2020 Chris Nevin. All rights reserved.
//

import Domain
import Foundation
import XCTest

class MapPresenterTests: XCTestCase {
    var locationService: MockLocationService!
    var dependencies: MockDependencies!
    var coordinator: MapCoordinator!
    var presenter: MapPresenter<MapView, MapCoordinator>!

    override func setUp() {
        super.setUp()
        locationService = MockLocationService()
        dependencies = MockDependencies(location: locationService)
        coordinator = MapCoordinator(dependencies: dependencies)
        presenter = MapPresenter(coordinator: coordinator)
    }

    func testAttachDetach() {
        locationService.enableLocationService()

        let view = MapView()
        presenter.attach(view: view)
        XCTAssertNotNil(view.spyLocation)
        presenter.detach()
        
        locationService.disableLocationService()
    }
}

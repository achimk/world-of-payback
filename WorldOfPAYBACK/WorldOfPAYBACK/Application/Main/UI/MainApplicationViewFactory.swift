//
//  MainApplicationViewFactory.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 31/01/2023.
//

import UIKit

struct MainApplicationViewFactory {
    
    static func make(
        coordinator: MainApplicationFlowCoordinating,
        container: Container = .shared) -> UIViewController
    {
        let localisation = container.resolve(MainApplicationLocalisation.self)
        let reachabilityService = container.resolve(ReachabilityService.self)
        let presenter = MainApplicationPresenter(
            coordinator: coordinator,
            localisation: localisation,
            reachabilityService: reachabilityService)
        let view = MainApplicationViewController(eventHandler: presenter)
        presenter.attach(view)
        return view
    }
}

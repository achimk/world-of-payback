//
//  ReachabilityService.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 31/01/2023.
//

import Foundation

protocol ReachabilityService {
    func addObserver(_ observer: ReachabilityObserving) -> Cancelable
    func start()
    func stop()
}

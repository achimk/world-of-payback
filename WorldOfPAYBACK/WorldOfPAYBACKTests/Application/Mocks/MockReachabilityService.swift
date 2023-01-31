//
//  MockReachabilityService.swift
//  WorldOfPAYBACKTests
//
//  Created by Joachim Kret on 31/01/2023.
//

import Foundation
@testable import WorldOfPAYBACK

class MockReachabilityService: ReachabilityService {
    private(set) var addObserverInvoked = false
    private(set) var startInvoked = false
    private(set) var stopInvoked = false
    private(set) weak var observer: ReachabilityObserving?
    
    func addObserver(_ observer: ReachabilityObserving) -> Cancelable {
        addObserverInvoked = true
        self.observer = observer
        return AnyCancelable { }
    }
    
    func start() {
        startInvoked = true
    }
    
    func stop() {
        stopInvoked = true
    }
}

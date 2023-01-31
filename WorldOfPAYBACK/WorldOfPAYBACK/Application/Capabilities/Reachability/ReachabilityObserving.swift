//
//  ReachabilityObserving.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 31/01/2023.
//

import Foundation

protocol ReachabilityObserving: AnyObject {
    func reachabilityService(_ reachabilityService: ReachabilityService, didFailureWith error: ReachabilityServiceError)
    func reachabilityService(_ reachabilityService: ReachabilityService, didChangeStatus status: ReachabilityStatus)
}

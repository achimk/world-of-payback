//
//  ReachabilityStatus.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 31/01/2023.
//

import Foundation

enum ReachabilityStatus {
    case reachable(viaWiFi: Bool)
    case unreachable
    
    var isReachable: Bool {
        switch self {
        case .reachable: return true
        case .unreachable: return false
        }
    }
}

extension ReachabilityStatus {
    
    init(connection: Reachability.Connection) {
        switch connection {
        case .unavailable: self = .unreachable
        case .cellular: self = .reachable(viaWiFi: false)
        case .wifi: self = .reachable(viaWiFi: true)
        }
    }
}

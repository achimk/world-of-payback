//
//  ReachabilityServiceError.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 31/01/2023.
//

import Foundation

enum ReachabilityServiceError: Error {
    case failedToCreate(Error)
    case failedToStart(Error)
}

extension ReachabilityServiceError {
    
    var isFailedToCreate: Bool {
        if case .failedToCreate = self {
            return true
        }
        return false
    }
    
    var isFailedToStart: Bool {
        if case .failedToStart = self {
            return true
        }
        return false
    }
}

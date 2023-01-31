//
//  ApplicationLocalisation+MainApplicationLocalisation.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 31/01/2023.
//

import Foundation

extension ApplicationLocalisation: MainApplicationLocalisation {
    
    func applicationSetupErrorMessage() -> String {
        return "Unable to setup your account!"
    }
    
    func applicationNetworkNotReachableErrorMessage() -> String {
        return "Network connection is not available!"
    }
}

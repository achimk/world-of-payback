//
//  MainApplicationLocalisation.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 31/01/2023.
//

import Foundation

protocol MainApplicationLocalisation {
    func applicationSetupErrorMessage() -> String
    func applicationNetworkNotReachableErrorMessage() -> String
}

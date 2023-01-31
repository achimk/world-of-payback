//
//  MainApplicationScreenState.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 31/01/2023.
//

import Foundation

enum MainApplicationScreenState {
    case initial
    case presentLoading
    case presentWarning
    case presentError
    case awaitingToPresent
    case presentRegular
}

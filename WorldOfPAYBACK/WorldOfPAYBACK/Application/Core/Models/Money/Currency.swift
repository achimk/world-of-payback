//
//  Currency.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

enum Currency: Equatable, Hashable {
    case EUR
    case GBP
    case USD
    case unknownCode(String)
}

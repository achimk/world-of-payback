//
//  CurrencyMapper.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import Foundation

struct CurrencyMapper {
    
    static func map(_ value: String) -> Currency {
        let value = value.uppercased()
        switch value {
        case "EUR": return .EUR
        case "USD": return .USD
        case "GBP": return .GBP
        default: return .unknownCode(value)
        }
    }
}

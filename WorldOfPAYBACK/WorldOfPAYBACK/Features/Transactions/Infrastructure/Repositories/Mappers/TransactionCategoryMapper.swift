//
//  TransactionCategoryMapper.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import Foundation

struct TransactionCategoryMapper {
    
    static func map(_ value: Int) -> TransactionCategory {
        switch value {
        case 1: return .shopping
        case 2: return .travel
        case 3: return .savings
        default: return .other
        }
    }
}

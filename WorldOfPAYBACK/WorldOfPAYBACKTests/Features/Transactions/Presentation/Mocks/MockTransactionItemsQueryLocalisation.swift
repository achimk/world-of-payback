//
//  MockTransactionItemsQueryLocalisation.swift
//  WorldOfPAYBACKTests
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation
@testable import WorldOfPAYBACK

class MockTransactionItemsQueryLocalisation: TransactionItemsQueryLocalisation {
    
    func titleForTransactionCategory(_ category: TransactionCategory) -> String {
        switch category {
        case .shopping: return "shopping"
        case .travel: return "travel"
        case .savings: return "savings"
        case .other: return "other"
        }
    }
    
    func clearButtonTitle() -> String {
        return "clear"
    }
    
    func acceptButtonTitle() -> String {
        return "accept"
    }
    
    
}

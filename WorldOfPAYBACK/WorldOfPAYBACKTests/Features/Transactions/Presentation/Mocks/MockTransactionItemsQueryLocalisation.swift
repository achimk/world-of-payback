//
//  MockTransactionItemsQueryLocalisation.swift
//  WorldOfPAYBACKTests
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation
@testable import WorldOfPAYBACK

class MockTransactionItemsQueryLocalisation: TransactionItemsQueryLocalisation {
    
    func transactionsQueryViewTitle() -> String {
        return "filter"
    }
    
    func transactionsQueryTitleForTransactionCategory(_ category: TransactionCategory) -> String {
        switch category {
        case .shopping: return "shopping"
        case .travel: return "travel"
        case .savings: return "savings"
        case .other: return "other"
        }
    }
    
    func transactionsQueryClearButtonTitle() -> String {
        return "clear"
    }
    
    func transactionsQueryAcceptButtonTitle() -> String {
        return "accept"
    }
}

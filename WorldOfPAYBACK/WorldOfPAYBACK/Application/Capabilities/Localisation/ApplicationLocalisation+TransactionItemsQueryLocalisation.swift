//
//  ApplicationLocalisation+TransactionItemsQueryLocalisation.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import Foundation

extension ApplicationLocalisation: TransactionItemsQueryLocalisation {
    func transactionsQueryTitleForTransactionCategory(_ category: TransactionCategory) -> String {
        switch category {
        case .shopping: return "Shopping"
        case .travel: return "Travel"
        case .savings: return "Savings"
        case .other: return "Other"
        }
    }
    
    func transactionsQueryClearButtonTitle() -> String {
        return "Clear"
    }
    
    func transactionsQueryAcceptButtonTitle() -> String {
        return "Accept"
    }
    
    
}

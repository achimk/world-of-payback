//
//  ApplicationLocalisation+TransactionItemsLocalisation.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import Foundation

extension ApplicationLocalisation: TransactionItemsLocalisation {
    
    func transactionItemsTitle() -> String {
        return "Transactions"
    }
    
    func transactionItemsLoadingFailed(with error: Error) -> String {
        return "Something went wrong!"
    }
}

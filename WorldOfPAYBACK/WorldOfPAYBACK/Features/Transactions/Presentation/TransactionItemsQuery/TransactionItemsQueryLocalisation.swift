//
//  TransactionItemsQueryLocalisation.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

protocol TransactionItemsQueryLocalisation {
    func titleForTransactionCategory(_ category: TransactionCategory) -> String
    func clearButtonTitle() -> String
    func acceptButtonTitle() -> String
}

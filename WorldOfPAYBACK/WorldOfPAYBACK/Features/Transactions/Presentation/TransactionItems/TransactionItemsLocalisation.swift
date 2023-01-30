//
//  TransactionItemsLocalisation.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

protocol TransactionItemsLocalisation {
    func transactionItemsLoadingFailed(with error: Error) -> String
}

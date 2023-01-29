//
//  SumOfAllTransactionsHandling.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

protocol SumOfAllTransactionsHandling {
    func allTransactionsSum(completion: @escaping Completion<CalculatedTransactions>) -> Cancelable
}

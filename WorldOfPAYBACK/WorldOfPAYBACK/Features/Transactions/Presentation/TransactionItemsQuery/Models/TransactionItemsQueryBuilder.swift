//
//  TransactionItemsQueryBuilder.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

protocol TransactionItemsQueryBuilder {
    func toggle(category: TransactionCategory) -> Self
    func clear() -> Self
    func build() -> TransactionItemsQuery
}

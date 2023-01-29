//
//  TransactionItemsQueryBuilder.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

struct TransactionItemsQueryBuilder {
    private var sortBy: TransactionItemQuery.SortBy
    private var filterCategories: Set<TransactionCategory>
    
    init(
        sortBy: TransactionItemQuery.SortBy,
        filterCategories: Set<TransactionCategory>
    ) {
        self.sortBy = sortBy
        self.filterCategories = filterCategories
    }
    
    func toggle(category: TransactionCategory) -> Self {
        return performOnCopy { builder in
            if builder.filterCategories.contains(category) {
                builder.filterCategories.remove(category)
            } else {
                builder.filterCategories.insert(category)
            }
        }
    }
    
    func clear() -> Self {
        return performOnCopy { builder in
            builder.filterCategories = []
        }
    }
    
    func build() -> TransactionItemQuery {
        return TransactionItemQuery(
            sortBy: sortBy,
            filterCategories: filterCategories)
    }
    
    private func performOnCopy(_ action: (inout TransactionItemsQueryBuilder) -> Void) -> Self {
        var builder = self
        action(&builder)
        return builder
    }
}

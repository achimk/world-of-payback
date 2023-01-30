//
//  MultiCategoriesQueryBuilder.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

struct MultiTransactionCategoriesQueryBuilder: TransactionItemsQueryBuilder {
    private var sortBy: TransactionItemsQuery.SortBy
    private var filterCategories: Set<TransactionCategory>

    init(query: TransactionItemsQuery) {
        self.sortBy = query.sortBy
        self.filterCategories = query.filterCategories
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
    
    func build() -> TransactionItemsQuery {
        return TransactionItemsQuery(
            sortBy: sortBy,
            filterCategories: filterCategories)
    }
    
    private func performOnCopy(_ action: (inout MultiTransactionCategoriesQueryBuilder) -> Void) -> Self {
        var builder = self
        action(&builder)
        return builder
    }
}

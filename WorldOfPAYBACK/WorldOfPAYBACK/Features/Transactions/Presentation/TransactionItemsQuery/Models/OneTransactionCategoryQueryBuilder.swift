//
//  OneCategoryQueryBuilder.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

struct OneTransactionCategoryQueryBuilder: TransactionItemsQueryBuilder {
    private var sortBy: TransactionItemsQuery.SortBy
    private var filterCategories: Set<TransactionCategory>
    
    init(query: TransactionItemsQuery) {
        self.sortBy = query.sortBy
        self.filterCategories = query.filterCategories.first.map { [$0] } ?? []
    }
    
    func toggle(category: TransactionCategory) -> Self {
        return performOnCopy { builder in
            if builder.filterCategories.contains(category) {
                builder.filterCategories = []
            } else {
                builder.filterCategories = []
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
    
    private func performOnCopy(_ action: (inout OneTransactionCategoryQueryBuilder) -> Void) -> Self {
        var builder = self
        action(&builder)
        return builder
    }
}

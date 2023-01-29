//
//  TransactionItemsQueryViewDataBuilder.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

struct TransactionItemsQueryViewDataBuilder {
    typealias FilterViewData = TransactionItemsQueryViewData.FilterViewData
    typealias ButtonViewData = TransactionItemsQueryViewData.ButtonViewData
    private let localisation: TransactionItemsQueryLocalisation
    private var onSelectClearHandler: () -> Void = { }
    private var onSelectAcceptHandler: () -> Void = { }
    private var onChangeCategoryHandler: (TransactionCategory) -> Void = { _ in }
    
    init(localisation: TransactionItemsQueryLocalisation) {
        self.localisation = localisation
    }
    
    func set(selectClearHandler: @escaping () -> Void) -> Self {
        return performOnCopy { builder in
            builder.onSelectClearHandler = selectClearHandler
        }
    }
    
    func set(selectAcceptHandler: @escaping () -> Void) -> Self {
        return performOnCopy { builder in
            builder.onSelectAcceptHandler = selectAcceptHandler
        }
    }
    
    func set(changeCategoryHandler: @escaping (TransactionCategory) -> Void) -> Self {
        return performOnCopy { builder in
            builder.onChangeCategoryHandler = changeCategoryHandler
        }
    }
    
    func build(for query: TransactionItemQuery) -> TransactionItemsQueryViewData {
        return TransactionItemsQueryViewData(
            filters: makeFilters(for: query),
            clearButton: makeClearButton(for: query),
            acceptButton: makeAcceptButton(for: query))
    }
    
    private func makeClearButton(for query: TransactionItemQuery) -> ButtonViewData {
        let isEnabled = !query.filterCategories.isEmpty
        return .init(
            title: localisation.clearButtonTitle(),
            isEnabled: isEnabled,
            onSelectHandler: onSelectClearHandler)
    }
    
    private func makeAcceptButton(for query: TransactionItemQuery) -> ButtonViewData {
        return .init(
            title: localisation.acceptButtonTitle(),
            isEnabled: true,
            onSelectHandler: onSelectAcceptHandler)
    }
    
    private func makeFilters(for query: TransactionItemQuery) -> [FilterViewData] {
        return TransactionCategory.allCases.map { makeFilter(for: $0, in: query.filterCategories) }
    }
    
    private func makeFilter(for category: TransactionCategory, in set: Set<TransactionCategory>) -> FilterViewData {
        return .init(
            name: localisation.titleForTransactionCategory(category),
            isEnabled: set.contains(category),
            onChangeHandler: { [onChangeCategoryHandler] in
                onChangeCategoryHandler(category)
            })
    }
    
    private func performOnCopy(_ action: (inout TransactionItemsQueryViewDataBuilder) -> Void) -> Self {
        var builder = self
        action(&builder)
        return builder
    }
}
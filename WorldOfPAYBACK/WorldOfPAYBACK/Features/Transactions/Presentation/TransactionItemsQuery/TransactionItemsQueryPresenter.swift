//
//  TransactionItemsQueryPresenter.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

class TransactionItemsQueryPresenter {
    private let coordinator: TransactionItemsQueryFlowCoordinating
    private var viewDataBuilder: TransactionItemsQueryViewDataBuilder
    private var queryBuilder: TransactionItemsQueryBuilder
    private weak var view: TransactionItemsQueryViewInterface?
    
    init(
        coordinator: TransactionItemsQueryFlowCoordinating,
        localisation: TransactionItemsQueryLocalisation,
        queryBuilder: TransactionItemsQueryBuilder
    ) {
        self.coordinator = coordinator
        self.viewDataBuilder = TransactionItemsQueryViewDataBuilder(localisation: localisation)
        self.queryBuilder = queryBuilder
        
        let onClearFilters: () -> Void = { [weak self] in self?.clearFilters() }
        let onAcceptQuery: () -> Void = { [weak self] in self?.acceptQuery() }
        let onChangeCategory: (TransactionCategory) -> Void = { [weak self] in self?.toggle(category: $0) }
        viewDataBuilder = viewDataBuilder
            .set(selectAcceptHandler: onAcceptQuery)
            .set(selectClearHandler: onClearFilters)
            .set(changeCategoryHandler: onChangeCategory)
    }
}

extension TransactionItemsQueryPresenter {
    
    func attach(_ view: TransactionItemsQueryViewInterface) {
        self.view = view
    }
}

extension TransactionItemsQueryPresenter: TransactionItemsQueryEventHandling {
    
    func viewLoaded() {
        buildAndNotify()
    }
    
    private func buildAndNotify() {
        let query = queryBuilder.build()
        let viewData = viewDataBuilder.build(for: query)
        view?.presentQueryViewData(viewData)
    }
    
    private func toggle(category: TransactionCategory) {
        queryBuilder = queryBuilder.toggle(category: category)
        buildAndNotify()
    }

    private func clearFilters() {
        queryBuilder = queryBuilder.clear()
        buildAndNotify()
    }
    
    private func acceptQuery() {
        let query = queryBuilder.build()
        coordinator.presentTransactionItems(for: query)
    }
}

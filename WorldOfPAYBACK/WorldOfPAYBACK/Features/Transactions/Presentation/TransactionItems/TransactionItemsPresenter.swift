//
//  TransactionItemsPresenter.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

class TransactionItemsPresenter {
    private let activityPublisher: ActivityStatePublisher<TransactionItemsQueryParameters, TransactionItemsWithSum>
    private let coordinator: TransactionItemsFlowCoordinating
    private let localisation: TransactionItemsLocalisation
    private let viewDataBuilder: CurrencyTransactionItemsViewDataBuilder
    private var query: TransactionItemsQuery
    private weak var view: TransactionItemsViewInterface?
    
    init(
        coordinator: TransactionItemsFlowCoordinating,
        dateFormatter: DateFormatting,
        currencyFormatter: CurrencyFormatting,
        localisation: TransactionItemsLocalisation,
        transactionsHandler: FetchAndSumTransactionsHandling,
        initialQuery query: TransactionItemsQuery
    ) {
        self.activityPublisher = .init { (parameters, completion) in
            return transactionsHandler.allTransactions(
                with: parameters.query,
                shouldSumTransactions: parameters.shouldSumTransactions,
                completion: completion)
        }
        self.coordinator = coordinator
        self.localisation = localisation
        let itemBuilder = TransactionItemViewDataBuilder(
            dateFormatter: dateFormatter,
            currencyFormatter: currencyFormatter)
        self.viewDataBuilder = CurrencyTransactionItemsViewDataBuilder(
            itemBuilder: itemBuilder,
            currencyFormatter: currencyFormatter,
            localisation: localisation)
        self.query = query
        
        itemBuilder.set(selectHandler: { item in
            coordinator.presentTransactionDetails(for: item)
        })
        
        activityPublisher.onStateUpdate = { [weak self] state in
            self?.handleStateUpdate(with: state)
        }
    }
}

extension TransactionItemsPresenter {
    
    func attach(_ view: TransactionItemsViewInterface) {
        self.view = view
    }
    
    func updateTransactionsQuery(_ query: TransactionItemsQuery) {
        self.query = query
        buildAndDispatch()
    }
}

extension TransactionItemsPresenter: TransactionItemsEventHandling {
    
    func viewLoaded() {
        handleStateUpdate(with: activityPublisher.currentState)
        buildAndDispatch()
    }
    
    func refreshContent() {
        buildAndDispatch()
    }
    
    func filterContent() {
        coordinator.presentTransactionFilters(for: query) { [weak self] in
            self?.updateTransactionsQuery($0)
        }
    }
    
    private func buildAndDispatch() {
        let shouldSumTransactions = !query.filterCategories.isEmpty
        let parameters = TransactionItemsQueryParameters(
            query: query,
            shouldSumTransactions: shouldSumTransactions)
        activityPublisher.dispatch(parameters)
    }
    
    private func handleStateUpdate(with state: ActivityState<TransactionItemsWithSum, Error>) {
        switch state {
        case .initial:
            view?.presentInitial()
        case .loading:
            view?.presentProgress()
        case .success(let result):
            view?.presentTransactionsViewData(viewDataBuilder.build(for: result))
        case .failure(let error):
            view?.presentErrorMessage(localisation.transactionItemsLoadingFailed(with: error))
        }
    }
}

// MARK: - Private

private struct TransactionItemsQueryParameters {
    let query: TransactionItemsQuery
    let shouldSumTransactions: Bool
}

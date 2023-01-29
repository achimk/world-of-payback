//
//  MockTransactionItemRepository.swift
//  WorldOfPAYBACKTests
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation
@testable import WorldOfPAYBACK

class MockTransactionItemRepository: TransactionItemRepository {
    private var shouldHoldCompletion: Bool = false
    private var completion: Completion<[TransactionItem]>?
    private(set) var allTransactionItemsInvoked = false
    var tranactionItemsGenerator: () throws -> [TransactionItem] = { [] }
    
    func setCompletionOnHold() {
        shouldHoldCompletion = true
    }
    
    func completeIfNeeded() {
        guard shouldHoldCompletion else { return }
        shouldHoldCompletion = false
        completion?(Result(catching: { try tranactionItemsGenerator() }))
        completion = nil
    }
    
    func allTransactionItems(completion: @escaping (Result<[TransactionItem], Error>) -> Void) -> Cancelable {
        allTransactionItemsInvoked = true
        if shouldHoldCompletion {
            self.completion = completion
        } else {
            completion(Result(catching: { try tranactionItemsGenerator() }))
        }
        return NoopCancelable()
    }
}

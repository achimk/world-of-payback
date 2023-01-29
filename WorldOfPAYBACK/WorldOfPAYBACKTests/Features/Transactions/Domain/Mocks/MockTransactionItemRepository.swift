//
//  MockTransactionItemRepository.swift
//  WorldOfPAYBACKTests
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation
@testable import WorldOfPAYBACK

class MockTransactionItemRepository: TransactionItemRepository {
    private(set) var allTransactionItemsInvoked = false
    var tranactionItemsGenerator: () throws -> [TransactionItem] = { [] }
    
    func allTransactionItems(completion: @escaping (Result<[TransactionItem], Error>) -> Void) -> Cancelable {
        allTransactionItemsInvoked = true
        completion(Result(catching: { try tranactionItemsGenerator() }))
        return NoopCancelable()
    }
}

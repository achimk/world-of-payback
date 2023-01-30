//
//  NetworkBasedTransactionItemRepository.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

class NetworkBasedTransactionItemRepository: TransactionItemRepository {
    
    func allTransactionItems(completion: @escaping Completion<[TransactionItem]>) -> Cancelable {
        // Backend API integration point
        completion(.failure(NSError(domain: "Not implemented!", code: 0, userInfo: nil)))
        return NoopCancelable()
    }
}

extension URLSessionTask: Cancelable {
}

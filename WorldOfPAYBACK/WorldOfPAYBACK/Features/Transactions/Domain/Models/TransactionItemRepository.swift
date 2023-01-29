//
//  TransactionItemRepository.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

protocol TransactionItemRepository {
    func allTransactionItems(completion: @escaping Completion<[TransactionItem]>) -> Cancelable
}

//
//  TransactionItemRepository.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

protocol TransactionItemRepository {
    func allTransactionItems(with query: TransactionItemQuery, completion: Completion<[TransactionItem]>) -> Cancelable
}

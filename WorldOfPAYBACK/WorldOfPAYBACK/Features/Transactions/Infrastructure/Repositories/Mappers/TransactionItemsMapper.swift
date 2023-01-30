//
//  TransactionItemsMapper.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import Foundation

class TransactionItemsMapper {
    
    static func map(_ response: TransactionItemsResponse) -> [TransactionItem] {
        return response.items?.compactMap(TransactionItemsMapper.map) ?? []
    }
    
    static func map(_ response: TransactionItemResponse) -> TransactionItem? {
        
        let category = response.category.map(TransactionCategoryMapper.map)
        let currency = response.transactionDetail?.value?.currency.map(CurrencyMapper.map)
        
        guard
            let partnerName = response.partnerDisplayName,
            let category = category,
            let summary = response.transactionDetail?.description,
            let bookingDate = response.transactionDetail?.bookingDate,
            let currency = currency,
            let amount = response.transactionDetail?.value?.amount
        else {
            return nil
        }
        
        return TransactionItem(
            partnerName: partnerName,
            category: category,
            summary: summary,
            bookingDate: bookingDate,
            amount: .init(amount: amount, currency: currency))
    }
}

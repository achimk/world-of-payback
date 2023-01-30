//
//  TransactionItemsResponse.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

// MARK: - TransactionItemsResponse
struct TransactionItemsResponse: Codable {
    var items: [TransactionItemResponse]?
}

// MARK: - Item
struct TransactionItemResponse: Codable {
    var partnerDisplayName: String?
    var alias: Alias?
    var category: Int?
    var transactionDetail: TransactionDetail?
}

extension TransactionItemResponse {
    
    // MARK: - Alias
    struct Alias: Codable {
        var reference: String?
    }
    
    // MARK: - TransactionDetail
    struct TransactionDetail: Codable {
        var description: String?
        var bookingDate: Date?
        var value: Value?
    }
    
    // MARK: - Value
    struct Value: Codable {
        @DecimalDecoder
        var amount: Decimal?
        var currency: String?
    }
}

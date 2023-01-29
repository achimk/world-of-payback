//
//  TransactionItemQuery.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

struct TransactionItemQuery {
    enum SortBy {
        case bookingDateAscending
        case bookingDateDescending
    }
    
    let sortBy: SortBy
    let filterCategories: Set<TransactionCategory>
}

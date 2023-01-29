//
//  TransactionItemsQueryViewData.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

struct TransactionItemsQueryViewData {
    
    struct FilterViewData {
        let name: String
        let isEnabled: Bool
        let onChangeHandler: () -> Void
    }
    
    struct ButtonViewData {
        let title: String
        let isEnabled: Bool
        let onSelectHandler: () -> Void
    }
    
    let filters: [FilterViewData]
    let clearButton: ButtonViewData
    let acceptButton: ButtonViewData
}

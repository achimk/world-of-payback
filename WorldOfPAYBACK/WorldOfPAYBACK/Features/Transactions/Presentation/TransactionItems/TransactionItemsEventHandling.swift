//
//  TransactionItemsEventHandling.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

protocol TransactionItemsEventHandling {
    func viewLoaded()
    func refreshContent()
    func filterContent()
}

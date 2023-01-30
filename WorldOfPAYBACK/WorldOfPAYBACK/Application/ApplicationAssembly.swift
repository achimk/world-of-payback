//
//  ApplicationAssembly.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

class ApplicationAssembly {
    
    static func assembleDependencies(with container: Container) {
        assembleUtilityDependencies(with: container)
        TransactionsAssembly.assembleDependencies(with: container)
    }
    
    private static func assembleUtilityDependencies(with container: Container) {
        container.register(CurrencyFormatting.self, value: DefaultCurrencyFormatter())
        container.register(DateFormatting.self, value: DefaultDateFormatter())
    }
}

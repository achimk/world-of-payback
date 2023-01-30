//
//  ApplicationAssembly.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

class ApplicationAssembly {
    
    static func assembleDependencies(with container: Container) {
        
        // Register core functionalities
        assembleUtilityDependencies(with: container)
        assembleCapabilityDependencies(with: container)
        
        // Register Features
        TransactionsAssembly.assembleDependencies(with: container)
    }
    
    private static func assembleUtilityDependencies(with container: Container) {
        container.register(CurrencyFormatting.self, value: DefaultCurrencyFormatter())
        container.register(DateFormatting.self, value: DefaultDateFormatter())
    }
    
    private static func assembleCapabilityDependencies(with container: Container) {
        
        // Register localisations
        let localisation = ApplicationLocalisation.shared
        container.register(AlertLocalisation.self, value: localisation)
        container.register(TransactionItemsLocalisation.self, value: localisation)
        container.register(TransactionItemsQueryLocalisation.self, value: localisation)
    }
}

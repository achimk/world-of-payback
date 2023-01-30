//
//  CurrencyMapperTests.swift
//  WorldOfPAYBACKTests
//
//  Created by Joachim Kret on 30/01/2023.
//

import Foundation
import XCTest
@testable import WorldOfPAYBACK

class CurrencyMapperTests: XCTestCase {
    
    func test_mapValues_shouldProduceCorrectCurrencies() {
        let inputs = ["EUR", "gbp", "Usd", "PBP"]
        let expectations: [Currency] = [
            .EUR, .GBP, .USD, .unknownCode("PBP")
        ]
        
        let results = inputs.map(CurrencyMapper.map)
        
        XCTAssertEqual(results, expectations)
    }
}

//
//  TransactionCategoryMapperTests.swift
//  WorldOfPAYBACKTests
//
//  Created by Joachim Kret on 30/01/2023.
//

import Foundation
import XCTest
@testable import WorldOfPAYBACK

class TransactionCategoryMapperTests: XCTestCase {
    
    func test_mapValues_shouldProduceCorrectCategories() {
        let inputs = [1, 2, 3, 4, 5, 6, 7, 8, 9, 100]
        let expectations: [TransactionCategory] = [
            .shopping,
            .travel,
            .savings,
            .other,
            .other,
            .other,
            .other,
            .other,
            .other,
            .other
        ]
        
        let results = inputs.map(TransactionCategoryMapper.map)
        
        XCTAssertEqual(results, expectations)
    }
}

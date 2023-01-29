//
//  MockDateFormatter.swift
//  WorldOfPAYBACKTests
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation
@testable import WorldOfPAYBACK

class MockDateFormatter: DateFormatting {
    var stringFromDateGenerator: (Date) -> String = { String(describing: $0) }
    func string(from date: Date, dateFormat: String) -> String {
        return stringFromDateGenerator(date)
    }
}

//
//  DecimalDecoder.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

@propertyWrapper
struct DecimalDecoder: Codable {
    var wrappedValue: Decimal?
    
    init(wrappedValue: Decimal?) {
        self.wrappedValue = wrappedValue
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let value = try? container.decode(Int.self) {
            wrappedValue = Decimal(value)
        } else if let _ = try? container.decode(String.self) {
            // TODO: provide String decoder!
            wrappedValue = nil
        } else if let _ = try? container.decode(Double.self) {
            print("Double decoding for decimal should be forbidden!")
            wrappedValue = nil
        } else {
            wrappedValue = nil
        }
    }
}

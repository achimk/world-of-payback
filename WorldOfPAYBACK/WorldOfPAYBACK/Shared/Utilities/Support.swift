//
//  Support.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

func abstractMethod(message: String? = nil, file: StaticString = #file, line: UInt = #line) -> Never {
    fatalError(message ?? "Subclasses should override method!", file: file, line: line)
}

func undefined<T>(_ message: String? = nil, file: StaticString = #file, line: UInt = #line) -> T {
    fatalError(message ?? "Undiefined \(T.self)!", file: file, line: line)
}

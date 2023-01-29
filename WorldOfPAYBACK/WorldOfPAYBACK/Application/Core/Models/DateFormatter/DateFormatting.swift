//
//  DateFormatting.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

protocol DateFormatting {
    func string(from date: Date, dateFormat: String) -> String
}

//
//  DateFormatting.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

enum DateFormat {
    case dateTime
    case shortDate
}

protocol DateFormatting {
    func string(from date: Date, dateFormat: DateFormat) -> String
}

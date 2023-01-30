//
//  DefaultDateFormatter.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import Foundation

class DefaultDateFormatter: DateFormatting {
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        dateFormatter.calendar = .current
        return dateFormatter
    }()
    
    func string(from date: Date, dateFormat: DateFormat) -> String {
        dateFormatter.dateFormat = stringDateFormat(dateFormat)
        return dateFormatter.string(from: date)
    }
}

private func stringDateFormat(_ dateFormat: DateFormat) -> String {
    switch dateFormat {
    case .dateTime: return "d MMMM yyyy HH:mm"
    case .shortDate: return "d MMMM yyyy"
    }
}

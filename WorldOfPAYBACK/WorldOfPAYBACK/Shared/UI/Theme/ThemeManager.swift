//
//  ThemeManager.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import Foundation

class ThemeManager {
    
    static let shared = ThemeManager()
    
    private let theme: Theme = Theme()
    
    private init() { }
}

extension ThemeManager {
    
    static func currentTheme() -> Theme {
        return shared.theme
    }
}

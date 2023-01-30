//
//  Bundle+Current.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import Foundation

extension Bundle {
    static func currentBundle() -> Bundle {
        return Bundle(for: BundleLoader.self)
    }
}

private final class BundleLoader { }

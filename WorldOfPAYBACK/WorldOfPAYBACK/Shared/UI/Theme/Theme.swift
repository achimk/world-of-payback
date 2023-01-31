//
//  Theme.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import Foundation
import UIKit

class Theme {
    let colors: Colors
    let systemIcons: SystemIcons
    
    init() {
        colors = Colors()
        systemIcons = SystemIcons()
    }
}

extension Theme {
    
    class Colors {
        let navigationBackground = UIColor.hex(0x7a9e9f)
        let navigarionItems = UIColor.white
        let navigationTexts = UIColor.white
        let checkmark = UIColor.hex(0x4f6367)
        let buttonPrimaryBackground = UIColor.hex(0xfe5f55)
        let buttonSecondaryBackground = UIColor.white
    }
}

extension Theme {
    
    class SystemIcons {
        lazy var filter: UIImage = { image(named: "filter_alt") }()
        lazy var checkmark: UIImage = { image(named: "check") }()
        lazy var close: UIImage = { image(named: "close") }()
        lazy var back: UIImage = { image(named: "arrow_back") }()
        lazy var error: UIImage = { image(named: "error") }()
        lazy var warning: UIImage = { image(named: "warning") }()
    }
}

extension Theme {
    
    func applyAppearance(for navigationBar: UINavigationBar) {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = colors.navigationBackground
        appearance.titleTextAttributes = [.foregroundColor: colors.navigationTexts]
        navigationBar.tintColor = colors.navigarionItems
        navigationBar.standardAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}

private func image(named imageName: String) -> UIImage {
    return UIImage(named: imageName) ?? undefined()
}

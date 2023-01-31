//
//  Theme.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import Foundation
import UIKit

class Theme {
    let systemIcons: SystemIcons
    
    init() {
        systemIcons = SystemIcons()
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


private func image(named imageName: String) -> UIImage {
    return UIImage(named: imageName) ?? undefined()
}

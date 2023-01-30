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
    }

}


private func image(named imageName: String) -> UIImage {
    return UIImage(named: imageName) ?? undefined()
}

//
//  Reusable.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import UIKit

protocol Reusable: AnyObject {
    static var reuseIdentifier: String { get }
}

extension Reusable where Self: UIView {
    
    static var reuseIdentifier: String {
        return String(describing: Self.self)
    }
}

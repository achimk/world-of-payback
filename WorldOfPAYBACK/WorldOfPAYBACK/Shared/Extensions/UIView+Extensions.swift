//
//  UIView+Extensions.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import UIKit

extension UIView {
    
    typealias Anchors = (
        top: NSLayoutConstraint,
        leading: NSLayoutConstraint,
        bottom: NSLayoutConstraint,
        trailing: NSLayoutConstraint
    )
    
    @discardableResult
    func addAndFill(_ subview: UIView, insets: UIEdgeInsets = .zero) -> Anchors {
        subview.translatesAutoresizingMaskIntoConstraints = false

        addSubview(subview)
        
        let anchors: Anchors
        anchors.top = subview.topAnchor.constraint(equalTo: topAnchor, constant: insets.top)
        anchors.leading = subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left)
        anchors.bottom = subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom)
        anchors.trailing = subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right)
        
        NSLayoutConstraint.activate([
            anchors.top,
            anchors.leading,
            anchors.bottom,
            anchors.trailing
        ])
        
        return anchors
    }
    
    func addAndPinBottom(_ subview: UIView, insets: UIEdgeInsets = .zero) {
        subview.translatesAutoresizingMaskIntoConstraints = false

        addSubview(subview)
        
        let anchors: Anchors
        anchors.leading = subview.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets.left)
        anchors.bottom = subview.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets.bottom)
        anchors.trailing = subview.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets.right)
        
        NSLayoutConstraint.activate([
            anchors.leading,
            anchors.bottom,
            anchors.trailing
        ])
    }
}

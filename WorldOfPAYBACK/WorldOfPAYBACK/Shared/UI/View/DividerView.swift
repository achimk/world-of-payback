//
//  DividerView.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 31/01/2023.
//

import UIKit

class DividerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        // TODO: Theme!
        backgroundColor = .lightGray
        NSLayoutConstraint.activate([
            heightAnchor.constraint(equalToConstant: 0.8)
        ])
    }
}

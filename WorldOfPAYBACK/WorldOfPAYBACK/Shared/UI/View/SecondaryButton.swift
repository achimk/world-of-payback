//
//  SecondaryButton.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 31/01/2023.
//

import UIKit

class SecondaryButton: UIView {
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)
        // TODO: Theme!
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.setBackgroundWithColor(.white, for: .normal)
        button.setBackgroundWithColor(.white, for: .disabled)
        button.setBackgroundWithColor(.white, for: .highlighted)
        button.setTitleColor(.darkGray, for: .normal)
        button.setTitleColor(.lightGray, for: .disabled)
        button.setTitleColor(.darkGray, for: .highlighted)
        button.layer.cornerRadius = 8
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.borderWidth = 0.8
        return button
    }()
    
    private var onSelectHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        addAndFill(button, insets: .init(top: 8, left: 16, bottom: 8, right: 16))
        heightAnchor.constraint(greaterThanOrEqualToConstant: 72).isActive = true
    }
    
    func setup(
        title: String,
        isEnabled: Bool,
        onSelectHandler: @escaping () -> Void
    ) {
        button.setTitle(title, for: .normal)
        button.setTitle(title, for: .disabled)
        button.setTitle(title, for: .highlighted)
        if button.isEnabled != isEnabled {
            button.isEnabled = isEnabled
        }
        self.onSelectHandler = onSelectHandler
    }
    
    @objc
    private func buttonSelected() {
        onSelectHandler?()
    }
}

//
//  PrimaryButton.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import UIKit

class PrimaryButton: UIView {
    
    private lazy var button: UIButton = {
        let button = UIButton()
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(buttonSelected), for: .touchUpInside)
        // TODO: Theme!
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.black, for: .disabled)
        button.setTitleColor(.black, for: .highlighted)
        button.setBackgroundWithColor(.red, for: .disabled)
        button.setBackgroundWithColor(.red, for: .highlighted)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.layer.cornerRadius = 5
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
        addAndFill(button, insets: .init(top: 16, left: 16, bottom: 16, right: 16))
        heightAnchor.constraint(greaterThanOrEqualToConstant: 80).isActive = true
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

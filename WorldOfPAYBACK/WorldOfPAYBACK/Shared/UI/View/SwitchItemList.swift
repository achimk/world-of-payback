//
//  SwitchItemList.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import UIKit

class SwitchItemList: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        // TODO: Theme!
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        // TODO: Theme!
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var switchButton: UISwitch = {
        let switchButton = UISwitch()
        switchButton.isOn = false
        switchButton.addTarget(self, action: #selector(switchButtonChanged), for: .valueChanged)
        return switchButton
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5.0
        return stackView
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5.0
        return stackView
    }()
    
    private lazy var dividerView: DividerView = {
        return DividerView()
    }()
    
    private var onChangeHandler: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(subtitleLabel)
        
        mainStackView.addArrangedSubview(labelsStackView)
        mainStackView.addArrangedSubview(switchButton)
        
        addAndFill(mainStackView, insets: .init(top: 16, left: 16, bottom: 16, right: 16))
        addAndPinBottom(dividerView, insets: .init(top: 0, left: 16, bottom: 0, right: 16))
    }
    
    func setup(
        title: String,
        subtitle: String?,
        isOn: Bool,
        onChangeHandler: @escaping () -> Void)
    {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        if switchButton.isOn != isOn {
            switchButton.isOn = isOn
        }
        self.onChangeHandler = onChangeHandler
    }
    
    @objc
    private func switchButtonChanged() {
        onChangeHandler?()
    }
}

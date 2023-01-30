//
//  TitleValueItemList.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import UIKit

class TitleValueItemList: UIView {
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        // TODO: Theme!
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        label.textAlignment = .left
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        // TODO: Theme!
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5.0
        return stackView
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        labelsStackView.addArrangedSubview(titleLabel)
        labelsStackView.addArrangedSubview(valueLabel)

        addAndFill(labelsStackView, insets: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    func setup(title: String, value: String?) {
        titleLabel.text = title
        valueLabel.text = value
    }
}


//
//  TransactionItemView.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import UIKit

class TransactonItemView: UIView {
    
    private lazy var iconImage: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    private lazy var partnerNameLabel: UILabel = {
        let label = UILabel()
        // TODO: Theme!
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        return label
    }()
    
    private lazy var amountLabel: UILabel = {
        let label = UILabel()
        // TODO: Theme!
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 18)
        label.numberOfLines = 1
        label.textAlignment = .right
        return label
    }()
    
    private lazy var summaryLabel: UILabel = {
        let label = UILabel()
        // TODO: Theme!
        label.textColor = .black
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 3
        return label
    }()
    
    private lazy var bookingDateLabel: UILabel = {
        let label = UILabel()
        // TODO: Theme!
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        label.textAlignment = .right
        return label
    }()
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5.0
        return stackView
    }()
    
    private lazy var headlineStackView: UIStackView = {
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
        headlineStackView.addArrangedSubview(partnerNameLabel)
        headlineStackView.addArrangedSubview(amountLabel)
        
        mainStackView.addArrangedSubview(headlineStackView)
        mainStackView.addArrangedSubview(summaryLabel)
        mainStackView.addArrangedSubview(bookingDateLabel)
        
        addAndFill(mainStackView, insets: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    func setup(with viewData: TransactionItemViewData) {
        partnerNameLabel.text = viewData.partnerName
        amountLabel.text = viewData.amount
        summaryLabel.text = viewData.summary
        bookingDateLabel.text = viewData.bookingDate
    }
}

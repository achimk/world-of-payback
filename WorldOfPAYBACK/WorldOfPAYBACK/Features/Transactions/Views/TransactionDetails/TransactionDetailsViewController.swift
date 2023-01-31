//
//  TransactionDetailsViewController.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import UIKit

class TransactionDetailsViewController: ScrollableStackViewController {
    private let eventHandler: TransactionDetailsEventHandling
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        // TODO: Theme!
        label.textColor = .black
        label.font = .boldSystemFont(ofSize: 24)
        label.textAlignment = .natural
        return label
    }()
    
    private lazy var summaryLabel: UILabel = {
        let label = UILabel()
        // TODO: Theme!
        label.textColor = .black
        label.font = .systemFont(ofSize: 18)
        label.textAlignment = .natural
        return label
    }()
    
    init(eventHandler: TransactionDetailsEventHandling) {
        self.eventHandler = eventHandler
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupStackView()
        eventHandler.viewLoaded()
    }
    
    private func setupStackView() {
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(summaryLabel)
    }
}

extension TransactionDetailsViewController: TransactionDetailsViewInterface {
    
    func presentTransactionDetails(viewData: TransactionDetailsViewData) {
        titleLabel.text = viewData.partnerName
        summaryLabel.text = viewData.summary
    }
}

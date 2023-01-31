//
//  InfoViewController.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 31/01/2023.
//

import UIKit

enum InfoViewStyle {
    case warning
    case error
}

class InfoViewController: ViewController {
    
    private let style: InfoViewStyle
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        // TODO: Theme!
        label.textColor = .black
        label.font = .systemFont(ofSize: 20)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        // TODO: Theme!
        label.textColor = .darkGray
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.spacing = 18
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = .init(top: 16, leading: 16, bottom: 16, trailing: 16)
        return stackView
    }()
    
    init(style: InfoViewStyle, title: String, subtitle: String?) {
        self.style = style
        super.init(nibName: nil, bundle: nil)
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewStyle()
        setupViews()
    }
    
    private func setupViews() {
        let topView = UIView()
        let bottomView = UIView()
        [view, topView, bottomView].forEach {
            $0?.backgroundColor = .white
        }
        
        stackView.addArrangedSubview(topView)
        stackView.addArrangedSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        stackView.addArrangedSubview(bottomView)
        view.addAndFill(stackView)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: 140),
            imageView.heightAnchor.constraint(equalToConstant: 140),
            topView.heightAnchor.constraint(equalTo: bottomView.heightAnchor)
        ])
    }
    
    private func setupViewStyle() {
        // TODO: Theme!
        let theme = ThemeManager.currentTheme()
        switch style {
        case .warning:
            imageView.image = theme.systemIcons.warning
            imageView.tintColor = .systemOrange
        case .error:
            imageView.image = theme.systemIcons.error
            imageView.tintColor = .systemPink
        }
    }
}

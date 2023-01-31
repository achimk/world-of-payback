//
//  LoadingViewController.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 31/01/2023.
//

import UIKit

class LoadingViewController: ViewController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        // TODO: Theme!
        view.backgroundColor = .white
        let loadingView = LoadingOverlayView()
        view.addAndFill(loadingView)
    }
}

//
//  ApplicationViewController.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 31/01/2023.
//

import UIKit

class MainApplicationViewController: ViewController {
    private let eventHandler: MainApplicationEventHandling
    private var currentViewController: UIViewController?
    
    init(eventHandler: MainApplicationEventHandling) {
        self.eventHandler = eventHandler
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventHandler.viewLoaded()
    }
}

extension MainApplicationViewController: MainApplicationViewInterface {
    
    func presentApplicationLoading() {
        toggleViewController(with: LoadingViewController())
    }
    
    func presentApplicationWarning(warningMessage: String) {
        toggleViewController(with: InfoViewController(style: .warning, title: warningMessage, subtitle: nil))
    }
    
    func presentApplicationError(errorMessage: String) {
        toggleViewController(with: InfoViewController(style: .error, title: errorMessage, subtitle: nil))
    }
    
    func presentApplicationView(viewController: UIViewController) {
        toggleViewController(with: viewController)
    }
    
    private func toggleViewController(with viewController: UIViewController) {
        toggle(from: currentViewController, to: viewController, inside: view, using: nil)
        currentViewController = viewController
    }
}

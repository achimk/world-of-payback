//
//  ApplicationFlowCoordinator.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 31/01/2023.
//

import UIKit

class MainApplicationFlowCoordinator {
    private let window = UIWindow()
    private let navigationController = NavigationController()
    private var applicationViewController: UIViewController = UIViewController()
    
    var currentWindow: UIWindow {
        return window
    }
    
    static let shared = MainApplicationFlowCoordinator()
    
    private init() { }
    
    func startFlow() {
        setupMainApplicationView()
        setupInitialFlow()
        window.makeKeyAndVisible()
    }
    
    private func setupMainApplicationView() {
        applicationViewController = MainApplicationViewFactory.make(coordinator: self)
        window.rootViewController = applicationViewController
    }
    
    private func setupInitialFlow() {
        let coordinator = TransactionsFlowCoordinator(navigationController: navigationController)
        let viewController = TransactionItemsViewFactory.make(coordinator: coordinator)
        navigationController.viewControllers = [viewController]
    }
}

extension MainApplicationFlowCoordinator: MainApplicationFlowCoordinating {
    
    func storeAndDismissCurrentView() {
        navigationController.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    func restoreAndPresentCurrentView(restoreReason: MainApplicationRestoreReason, completion: @escaping (UIViewController) -> Void) {
        completion(navigationController)
    }
}

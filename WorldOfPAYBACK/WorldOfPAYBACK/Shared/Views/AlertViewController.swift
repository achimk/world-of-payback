//
//  AlertViewController.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import UIKit

protocol AlertLocalisation {
    func alertFailedTitle() -> String
    func alertAcceptButtonTitle() -> String
}

class AlertViewController: UIAlertController {
    var onAcceptHandler: (() -> Void)?
    
    convenience init(message: String, localisation: AlertLocalisation) {
        self.init(
            title: localisation.alertFailedTitle(),
            message: message,
            preferredStyle: .alert)
        
        let acceptAction = UIAlertAction(
            title: localisation.alertAcceptButtonTitle(),
            style: .default,
            handler: { [weak self] _ in
                self?.handleAcceptAction()
            })
        addAction(acceptAction)
    }
    
    private func handleAcceptAction() {
        onAcceptHandler?()
    }
}

extension UIViewController {
    
    func presentError(message: String, container: Container = .shared) {
        let localisation = container.resolve(AlertLocalisation.self)
        present(AlertViewController(message: message, localisation: localisation),
                animated: true,
                completion: nil)
    }
}




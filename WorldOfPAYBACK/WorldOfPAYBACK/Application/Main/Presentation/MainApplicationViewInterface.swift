//
//  MainApplicationViewInterface.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 31/01/2023.
//

import UIKit

protocol MainApplicationViewInterface: AnyObject {
    func presentApplicationLoading()
    func presentApplicationWarning(warningMessage: String)
    func presentApplicationError(errorMessage: String)
    func presentApplicationView(viewController: UIViewController)
}

//
//  MainApplicationFlowCoordinating.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 31/01/2023.
//

import UIKit

protocol MainApplicationFlowCoordinating {
    func storeAndDismissCurrentView()
    func restoreAndPresentCurrentView(restoreReason: MainApplicationRestoreReason, completion: @escaping (UIViewController) -> Void)
}

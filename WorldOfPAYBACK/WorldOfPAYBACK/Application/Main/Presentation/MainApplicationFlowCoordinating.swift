//
//  MainApplicationFlowCoordinating.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 31/01/2023.
//

import UIKit

protocol MainApplicationFlowCoordinating {
    func restoreAndPresentCurrentView(restoreReason: MainApplicationResoreReason, completion: @escaping (UIViewController) -> Void)
}

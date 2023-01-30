//
//  ApplicationLocalisation+AlertLocalisation.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 30/01/2023.
//

import Foundation

extension ApplicationLocalisation: AlertLocalisation {
    
    func alertFailedTitle() -> String {
        return "Error"
    }
    
    func alertAcceptButtonTitle() -> String {
        return "OK"
    }
}

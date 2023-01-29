//
//  NoopCancelable.swift
//  async-transform
//
//  Created by Joachim Kret on 25/01/2023.
//

import Foundation

// No operation cancelable
final class NoopCancelable: Cancelable {
    
    init() { }
    
    func cancel() {
        // nothing to do
    }
}

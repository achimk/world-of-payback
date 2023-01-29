//
//  AnyCancelable.swift
//  async-transform
//
//  Created by Joachim Kret on 25/01/2023.
//

import Foundation

class AnyCancelable: Cancelable {
    private let lock = NSLock()
    private let block: () -> Void
    private(set) var isCanceled = false
    
    init(_ block: @escaping () -> Void) {
        self.block = block
    }
    
    deinit {
        cancel()
    }
    
    func cancel() {
        if isCanceled {
            return
        }

        lock.lock()
        defer { lock.unlock() }
        
        block()
        isCanceled = true
    }
}

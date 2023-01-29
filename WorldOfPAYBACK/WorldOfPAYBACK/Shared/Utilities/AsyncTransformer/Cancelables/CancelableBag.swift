//
//  CancelableBag.swift
//  async-transform
//
//  Created by Joachim Kret on 25/01/2023.
//

import Foundation

class CancelableBag: Cancelable {
    private let lock = NSLock()
    private var cancelables: [Cancelable] = []
    private(set) var isCanceled = false
    
    deinit {
        cancel()
    }
    
    init() { }
    
    func append(_ cancelables: Cancelable...) {
        appendOrCancel(cancelables)
    }
    
    func append(_ cancelables: [Cancelable]) {
        appendOrCancel(cancelables)
    }
    
    func cancel() {
        if isCanceled {
            return
        }

        lock.lock()
        defer { lock.unlock() }

        cancelables.forEach { $0.cancel() }
        cancelables = []
        isCanceled = true
    }
    
    private func appendOrCancel(_ cancelables: [Cancelable]) {
        if isCanceled {
            cancelables.forEach { $0.cancel() }
        } else {
            self.cancelables.append(contentsOf: cancelables)
        }
    }
}

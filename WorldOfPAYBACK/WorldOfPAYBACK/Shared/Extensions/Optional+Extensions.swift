//
//  Optional+Extensions.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

extension Optional {
    
    func ifPresent(_ action: (Wrapped) -> ()) {
        ifPresent(action, otherwise: { })
    }
    
    func ifPresent(_ action: (Wrapped) -> (), otherwise: () -> ()) {
        switch self {
        case .none: otherwise()
        case .some(let value): action(value)
        }
    }
    
    var isPresent: Bool {
        return map { _ in true } ?? false
    }
}

extension Optional {
    
    func or(else value: Wrapped) -> Wrapped {
        return self == nil ? value : self!
    }
    
    func or(else action: () -> Wrapped) -> Wrapped {
        return self == nil ? action() : self!
    }
    
    func or(else value: Optional<Wrapped>) -> Optional<Wrapped> {
        return self == nil ? value : self
    }
    
    func or(else action: () -> Optional<Wrapped>) -> Optional<Wrapped> {
        return self == nil ? action() : self
    }
}


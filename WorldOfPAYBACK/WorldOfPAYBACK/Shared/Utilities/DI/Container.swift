//
//  Container.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

final class Container {
    
    typealias Resolver = (Container) -> Any
    
    private var resolverByIdentifier: [String: Resolver] = [:]
    
    static let shared = Container()
    
    func contains<T>(_ type: T.Type) -> Bool {
        let key = String(describing: T.self)
        return resolverByIdentifier[key] != nil
    }
    
    func register<T>(_ type: T.Type, resolver: @escaping (Container) -> T) {
        let key = String(describing: T.self)
        resolverByIdentifier[key] = resolver
    }
    
    func resolve<T>(_ type: T.Type, otherwise: (() -> T)? = nil) -> T {
        let key = String(describing: T.self)
        
        guard let resolver = resolverByIdentifier[key] else {
            return otherwise?() ?? undefined("Missing resolver for \(key) type!")
        }
        
        return resolver(self) as? T ?? undefined("Invalida registered type for \(key)")
    }
    
    func unregisterAll() {
        resolverByIdentifier.removeAll()
    }
}

extension Container {
    
    func register<T>(_ type: T.Type, value: T) {
        let key = String(describing: T.self)
        resolverByIdentifier[key] = { _ in value }
    }
}

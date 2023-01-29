//
//  ActivityState.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

enum ActivityState<Success, Failure> {
    case initial
    case loading
    case success(Success)
    case failure(Failure)
}

extension ActivityState {
    
    var isInitial: Bool {
        if case .initial = self { return true }
        else { return false }
    }
    
    var isLoading: Bool {
        if case .loading = self { return true }
        else { return false }
    }
    
    var isSuccess: Bool {
        if case .success = self { return true }
        else { return false }
    }
    
    var isFailure: Bool {
        if case .failure = self { return true }
        else { return false }
    }
    
    var isFinish: Bool {
        return isSuccess || isFailure
    }
    
    func ifInitial(_ action: () -> ()) {
        if case .initial = self { action() }
    }
    
    func ifLoading(_ action: () -> ()) {
        if case .loading = self { action() }
    }
    
    func ifSuccess(_ action: (Success) -> ()) {
        if case .success(let value) = self { action(value) }
    }
    
    func ifFailure(_ action: (Failure) -> ()) {
        if case .failure(let error) = self { action(error) }
    }
    
    func ifFinish(_ action: () -> ()) {
        if isFinish{ action() }
    }
}

extension ActivityState {
    
    func map<U>(_ f: (Success) -> U) -> ActivityState<U, Failure> {
        switch self {
        case .initial: return .initial
        case .loading: return .loading
        case .success(let value): return .success(f(value))
        case .failure(let error): return .failure(error)
        }
    }
    
    func mapError<U>(_ f: (Failure) -> U) -> ActivityState<Success, U> {
        switch self {
        case .initial: return .initial
        case .loading: return .loading
        case .success(let value): return .success(value)
        case .failure(let error): return .failure(f(error))
        }
    }
}

extension ActivityState {
    
    var value: Success? {
        switch self {
        case .initial: return nil
        case .loading: return nil
        case .success(let value): return value
        case .failure: return nil
        }
    }
    
    var error: Failure? {
        switch self {
        case .initial: return nil
        case .loading: return nil
        case .success: return nil
        case .failure(let error): return error
        }
    }
}

extension ActivityState where Failure: Swift.Error {
    
    var result: Result<Success, Failure>? {
        switch self {
        case .initial: return nil
        case .loading: return nil
        case .success(let value): return .success(value)
        case .failure(let error): return .failure(error)
        }
    }
}

extension ActivityState: Equatable where Success: Equatable, Failure: Equatable {
    
    static func ==(lhs: ActivityState<Success, Failure>, rhs: ActivityState<Success, Failure>) -> Bool {
        switch (lhs, rhs) {
        case (.initial, .initial): return true
        case (.loading, .loading): return true
        case let (.success(l), .success(r)): return l == r
        case let (.failure(l), .failure(r)): return l == r
        default: return false
        }
    }
}

//
//  ActivityLoader.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

class ActivityStatePublisher<Input, Output> {
    typealias State = ActivityState<Output, Error>
    private let activityFactory: (Input, @escaping Completion<Output>) -> Cancelable
    private var cancelToken: Cancelable = NoopCancelable()
    private var internalState: State = .initial {
        didSet { onStateUpdate(internalState) }
    }
    
    var currentState: State {
        return internalState
    }
    
    var onStateUpdate: (State) -> Void = { _ in }
    
    init(_ activityFactory: @escaping (Input, @escaping Completion<Output>) -> Cancelable) {
        self.activityFactory = activityFactory
    }
    
    deinit {
        cancelToken.cancel()
    }
    
    func dispatch(_ input: Input, force: Bool = false) {
        guard !internalState.isLoading || force else {
            return
        }
        
        internalState = .loading
        cancelToken.cancel()
        cancelToken = activityFactory(input) { [weak self] result in
            self?.updateInternalState(with: result)
        }
    }
    
    private func updateInternalState(with result: Result<Output, Error>) {
        switch result {
        case .success(let value):
            internalState = .success(value)
        case .failure(let error):
            internalState = .failure(error)
        }
    }
}

extension ActivityStatePublisher where Input == Void {
    
    convenience init(_ activityFactory: @escaping (@escaping Completion<Output>) -> Cancelable) {
        self.init { (_, completion) in
            return activityFactory(completion)
        }
    }
    
    func dispatch(force: Bool = false) {
        dispatch((), force: force)
    }
}

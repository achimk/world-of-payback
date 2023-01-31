//
//  DeviceReachabilityService.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 31/01/2023.
//

import Foundation

class DeviceReachabilityService: ReachabilityService {
    private let reachabilityFactory: () throws -> Reachability
    private var reachability: Reachability?
    private var observers: [ReachabilityObserver] = []
    
    init(reachabilityFactory: @escaping () throws -> Reachability = { try Reachability() }) {
        self.reachabilityFactory = reachabilityFactory
    }

    deinit {
        stop()
    }

    func addObserver(_ observer: ReachabilityObserving) -> Cancelable {
        let observer = ReachabilityObserver(observer)
        observers.append(observer)
        return AnyCancelable { [weak self] in
            let index = self?.observers.firstIndex(where: { $0 === observer })
            index.ifPresent { self?.observers.remove(at: $0) }
        }
    }
    
    func start() {
        do {
            try createReachabilityIfNeeded()
        } catch {
            notifyReachabilityCreateFailure(error)
        }
        
        do {
            try reachability?.startNotifier()
        } catch {
            notifyReachabilityStartFailure(error)
        }
    }
    
    func stop() {
        reachability?.stopNotifier()
    }

    private func createReachabilityIfNeeded() throws {
        guard reachability == nil else { return }
        reachability = try reachabilityFactory()
        reachability?.whenReachable = { [weak self] in
            self?.notifyReachabilityStatusChanged(.init(connection: $0.connection))
        }
        reachability?.whenUnreachable = { [weak self] in
            self?.notifyReachabilityStatusChanged(.init(connection: $0.connection))
        }
    }
    
    private func notifyReachabilityCreateFailure(_ error: Error) {
        observers.forEach {
            $0.value?.reachabilityService(self, didFailureWith: .failedToCreate(error))
        }
    }
    
    private func notifyReachabilityStartFailure(_ error: Error) {
        observers.forEach {
            $0.value?.reachabilityService(self, didFailureWith: .failedToStart(error))
        }
    }
    
    private func notifyReachabilityStatusChanged(_ status: ReachabilityStatus) {
        observers.forEach {
            $0.value?.reachabilityService(self, didChangeStatus: status)
        }
    }
}

private class ReachabilityObserver {
    weak var value: ReachabilityObserving?
    init(_ value: ReachabilityObserving) {
        self.value = value
    }
}

//
//  DeviceReachibilityServiceTests.swift
//  WorldOfPAYBACKTests
//
//  Created by Joachim Kret on 31/01/2023.
//

import Foundation
import XCTest
@testable import WorldOfPAYBACK

class DeviceReachibilityServiceTests: XCTestCase {
    
    func test_startWhenUnableToCreate_shouldNotifyError() {
        let components = makeTestComponents(shouldFailureOnCreate: true)
        components.reachabilityService.start()
        XCTAssertFalse(components.observer.didChangeStatusInvoked)
        XCTAssertTrue(components.observer.didFailureWithErrorInvoked)
        XCTAssertTrue(components.observer.failureSnapshots.last?.isFailedToCreate == true)
    }
    
    func test_startWhenUnableToStartNotifier_shouldNotifyError() {
        let components = makeTestComponents(shouldFailureOnStart: true)
        components.reachabilityService.start()
        XCTAssertFalse(components.observer.didChangeStatusInvoked)
        XCTAssertTrue(components.observer.didFailureWithErrorInvoked)
        XCTAssertTrue(components.observer.failureSnapshots.last?.isFailedToStart == true)
    }
    
    func test_startWithoutIssues_shouldNotifyStatus() {
        let components = makeTestComponents()
        components.reachabilityService.start()
        XCTAssertTrue(components.observer.didChangeStatusInvoked)
        XCTAssertFalse(components.observer.didFailureWithErrorInvoked)
    }
    
    func test_changeReachabilityStatus_shouldNotifyObservers() {
        let components = makeTestComponents()
        components.reachabilityService.start()
        XCTAssertTrue(components.observer.didChangeStatusInvoked)
        XCTAssertFalse(components.observer.didFailureWithErrorInvoked)
    }
    
    func test_addObserver_shouldReceiveResults() {
        let observer = MockReachabilityObserver()
        let components = makeTestComponents()
        let token = components.reachabilityService.addObserver(observer)
        components.reachabilityService.start()
        XCTAssertTrue(observer.didChangeStatusInvoked)
        XCTAssertFalse(observer.didFailureWithErrorInvoked)
        token.cancel()
    }
    
    func test_cancelAddedObserver_shouldNotReceiveResults() {
        let observer = MockReachabilityObserver()
        let components = makeTestComponents()
        let token = components.reachabilityService.addObserver(observer)
        components.reachabilityService.start()
        token.cancel()
        components.reachabilityService.stop()
        XCTAssertEqual(components.observer.statusChangeSnapshots.count, 2)
        XCTAssertEqual(observer.statusChangeSnapshots.count, 1)
    }
}

extension DeviceReachibilityServiceTests {
    
    private struct TestComponents {
        let reachabilityFactory: MockReachabilityFactory
        let observer: MockReachabilityObserver
        let observerCancelToken: Cancelable
        let reachabilityService: DeviceReachibilityService
    }
    
    private func makeTestComponents(shouldFailureOnCreate: Bool = false, shouldFailureOnStart: Bool = false) -> TestComponents {
        let reachabilityFactory = MockReachabilityFactory()
        reachabilityFactory.shouldFailureOnCreate = shouldFailureOnCreate
        reachabilityFactory.cacheIfNeeded()
        reachabilityFactory.currentReachability?.shouldFailureOnStart = shouldFailureOnStart
        let observer = MockReachabilityObserver()
        let reachabilityService = DeviceReachibilityService(reachabilityFactory: {
            try reachabilityFactory.make()
        })
        let observerCancelToken = reachabilityService.addObserver(observer)
        return TestComponents(
            reachabilityFactory: reachabilityFactory,
            observer: observer,
            observerCancelToken: observerCancelToken,
            reachabilityService: reachabilityService)
    }
}

// MARK: - Mocks

class MockReachabilityFactory {
    var shouldFailureOnCreate: Bool = false
    private(set) var currentReachability: MockReachability?
    
    func cacheIfNeeded() {
        guard currentReachability == nil else {
            return
        }
        currentReachability = try? MockReachability()
    }
    
    func make() throws -> MockReachability {
        cacheIfNeeded()
        guard let currentReachability = currentReachability, !shouldFailureOnCreate else {
            throw NSError(domain: "ReachabilityCreateFailure", code: 0, userInfo: nil)
        }
        return currentReachability
    }
}

class MockReachability: Reachability {
    
    var internalConnectionState: Reachability.Connection = .unavailable
    var shouldFailureOnStart = false
    private(set) var startNotifierInvoked = false
    private(set) var stopNotifierInvoked = false
    
    override var connection: Reachability.Connection {
        return internalConnectionState
    }
    
    override func startNotifier() throws {
        startNotifierInvoked = true
        
        if shouldFailureOnStart {
            throw NSError(domain: "ReachabilityStartFailure", code: 0, userInfo: nil)
        }
        
        whenReachable?(self)
    }
    
    override func stopNotifier() {
        stopNotifierInvoked = true
        whenUnreachable?(self)
    }
}

class MockReachabilityObserver: ReachabilityObserving {
    private(set) var didFailureWithErrorInvoked = false
    private(set) var didChangeStatusInvoked = false
    private(set) var failureSnapshots: [ReachabilityServiceError] = []
    private(set) var statusChangeSnapshots: [ReachabilityStatus] = []
    
    func reachabilityService(_ reachabilityService: ReachabilityService, didFailureWith error: ReachabilityServiceError) {
        didFailureWithErrorInvoked = true
        failureSnapshots.append(error)
    }
    
    func reachabilityService(_ reachabilityService: ReachabilityService, didChangeStatus status: ReachabilityStatus) {
        didChangeStatusInvoked = true
        statusChangeSnapshots.append(status)
    }
}

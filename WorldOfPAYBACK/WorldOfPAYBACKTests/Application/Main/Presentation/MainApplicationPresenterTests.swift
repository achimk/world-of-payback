//
//  MainApplicationPresenterTests.swift
//  WorldOfPAYBACKTests
//
//  Created by Joachim Kret on 31/01/2023.
//

import Foundation
import XCTest
@testable import WorldOfPAYBACK

class MainApplicationPresenterTests: XCTestCase {
    
    func test_viewLoaded_shouldStartReachabilityService() {
        let components = makeTestComponents()
        components.presenter.viewLoaded()
        XCTAssertTrue(components.reachabilityService.startInvoked)
    }
    
    func test_viewLoaded_shouldPresentLoadingState() {
        let components = makeTestComponents()
        components.presenter.viewLoaded()
        XCTAssertTrue(components.view.presentApplicationLoadingInvoked)
    }
    
    func test_reachabilityFailure_shouldPresentErrorState() {
        let components = makeTestComponents()
        components.presenter.viewLoaded()
        components.reachabilityService.observer?.reachabilityService(components.reachabilityService, didFailureWith: .failedToStart(NSError(domain: "Error", code: 0, userInfo: nil)))
        XCTAssertTrue(components.view.presentApplicationErrorInvoked)
    }
    
    func test_statusChangedToUnreachable_shouldPresentWarningState() {
        let components = makeTestComponents()
        components.presenter.viewLoaded()
        components.reachabilityService.observer?.reachabilityService(components.reachabilityService, didChangeStatus: .unreachable)
        XCTAssertTrue(components.view.presentApplicationWarningInvoked)
    }
    
    func test_statusChangedToReachable_shouldRestoreView() {
        let components = makeTestComponents()
        components.presenter.viewLoaded()
        components.reachabilityService.observer?.reachabilityService(components.reachabilityService, didChangeStatus: .reachable(viaWiFi: true))
        XCTAssertTrue(components.view.presentApplicationViewInvoked)
    }
}

extension MainApplicationPresenterTests {
    
    private struct TestComponents {
        let presenter: MainApplicationPresenter
        let coordinator: MockMainApplicationFlowCoordinator
        let reachabilityService: MockReachabilityService
        let view: MockMainApplicationView
    }
    
    private func makeTestComponents() -> TestComponents {
        let coordinator = MockMainApplicationFlowCoordinator()
        let localisation = MockMainApplicationLocalisation()
        let reachabilityService = MockReachabilityService()
        let view = MockMainApplicationView()
        let presenter = MainApplicationPresenter(coordinator: coordinator, localisation: localisation, reachabilityService: reachabilityService)
        presenter.attach(view)
        
        return TestComponents(
            presenter: presenter,
            coordinator: coordinator,
            reachabilityService: reachabilityService,
            view: view)
    }
}

// MARK: - Mocks

class MockMainApplicationFlowCoordinator: MainApplicationFlowCoordinating {
    private(set) var restoreAndPresentCurrentViewInvoked = false
    
    func restoreAndPresentCurrentView(restoreReason: MainApplicationResoreReason, completion: @escaping (UIViewController) -> Void) {
        restoreAndPresentCurrentViewInvoked = true
        completion(UIViewController())
    }
}

class MockMainApplicationLocalisation: MainApplicationLocalisation {
    
    func applicationSetupErrorMessage() -> String {
        return "error"
    }
    
    func applicationNetworkNotReachableErrorMessage() -> String {
        return "error"
    }
}

class MockMainApplicationView: MainApplicationViewInterface {
    private(set) var presentApplicationLoadingInvoked = false
    private(set) var presentApplicationWarningInvoked = false
    private(set) var presentApplicationErrorInvoked = false
    private(set) var presentApplicationViewInvoked = false
    
    func presentApplicationLoading() {
        presentApplicationLoadingInvoked = true
    }
    
    func presentApplicationWarning(warningMessage: String) {
        presentApplicationWarningInvoked = true
    }
    
    func presentApplicationError(errorMessage: String) {
        presentApplicationErrorInvoked = true
    }
    
    func presentApplicationView(viewController: UIViewController) {
        presentApplicationViewInvoked = true
    }
}

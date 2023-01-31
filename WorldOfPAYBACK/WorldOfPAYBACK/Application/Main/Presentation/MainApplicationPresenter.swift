//
//  MainApplicationPresenter.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 31/01/2023.
//

import UIKit

class MainApplicationPresenter {
    private let coordinator: MainApplicationFlowCoordinating
    private let localisation: MainApplicationLocalisation
    private let reachabilityService: ReachabilityService
    private var cancelToken: Cancelable = NoopCancelable()
    private var screenState: MainApplicationScreenState = .initial
    private weak var view: MainApplicationViewInterface?
    
    init(
        coordinator: MainApplicationFlowCoordinating,
        localisation: MainApplicationLocalisation,
        reachabilityService: ReachabilityService
    ) {
        self.coordinator = coordinator
        self.localisation = localisation
        self.reachabilityService = reachabilityService
        self.cancelToken = reachabilityService.addObserver(self)
    }
}

extension MainApplicationPresenter {
    
    func attach(_ view: MainApplicationViewInterface) {
        self.view = view
    }
}

extension MainApplicationPresenter: MainApplicationEventHandling {
    
    func viewLoaded() {
        screenState = .presentLoading
        reachabilityService.start()
        view?.presentApplicationLoading()
    }
}

extension MainApplicationPresenter: ReachabilityObserving {
    
    func reachabilityService(_ reachabilityService: ReachabilityService, didFailureWith error: ReachabilityServiceError) {
        screenState = .presentError
        view?.presentApplicationError(errorMessage: localisation.applicationSetupErrorMessage())
    }
    
    func reachabilityService(_ reachabilityService: ReachabilityService, didChangeStatus status: ReachabilityStatus) {
        switch status {
        case .reachable:
            guard screenState != .awaitingToPresent || screenState != .presentRegular else { return }
            screenState = .awaitingToPresent
            let completion: (UIViewController) -> Void = { [weak self] in
                self?.screenState = .presentRegular
                self?.view?.presentApplicationView(viewController: $0)
            }
            coordinator.restoreAndPresentCurrentView(restoreReason: .networkReachable, completion: completion)
        case .unreachable:
            screenState = .presentWarning
            view?.presentApplicationWarning(warningMessage: localisation.applicationNetworkNotReachableErrorMessage())
        }
    }
}

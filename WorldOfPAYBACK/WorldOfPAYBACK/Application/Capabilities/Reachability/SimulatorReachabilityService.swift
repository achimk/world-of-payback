//
//  SimulatorReachabilityService.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 31/01/2023.
//

import Foundation

class SimulatorReachabilityService {
    typealias TimerFactory = (TimeInterval, Bool, @escaping () -> Void) -> Timer
    private let timerFactory: TimerFactory
    private var unreachableTimer: Timer?
    private var durationTimer: Timer?
    private var everyTimeInterval: TimeInterval = 0
    private var durationTimeInterval: TimeInterval = 0
    private var isEnabled = false
    private var observers: [ReachabilityObserver] = []
    
    init(timerFactory: @escaping TimerFactory = timerFactory(timeInterval:repeats:block:)) {
        self.timerFactory = timerFactory
    }
    
    deinit {
        invalidateTimers()
    }
    
    func setUnreachable(every: TimeInterval, duration: TimeInterval) {
        everyTimeInterval = max(0, every)
        durationTimeInterval = max(0, duration)
    }
    
    private func scheduleIfPossible() {
        guard isEnabled, everyTimeInterval > 0, durationTimeInterval > 0 else { return }
        scheduleUnreachableTimer()
    }
    
    private func scheduleUnreachableTimer() {
        unreachableTimer = timerFactory(everyTimeInterval, false) { [weak self] in
            self?.notifyUnreachable()
            self?.scheduleDurationTimer()
        }
    }
    
    private func scheduleDurationTimer() {
        durationTimer = timerFactory(durationTimeInterval, false) { [weak self] in
            self?.notifyReachable()
            self?.scheduleUnreachableTimer()
        }
    }
    
    private func invalidateTimers() {
        unreachableTimer?.invalidate()
        unreachableTimer = nil
        durationTimer?.invalidate()
        durationTimer = nil
    }
    
    private func notifyUnreachable() {
        observers.forEach {
            $0.value?.reachabilityService(self, didChangeStatus: .unreachable)
        }
    }
    
    private func notifyReachable() {
        observers.forEach {
            $0.value?.reachabilityService(self, didChangeStatus: .reachable(viaWiFi: true))
        }
    }
}

extension SimulatorReachabilityService: ReachabilityService {
    
    func addObserver(_ observer: ReachabilityObserving) -> Cancelable {
        let observer = ReachabilityObserver(observer)
        observers.append(observer)
        return AnyCancelable { [weak self] in
            let index = self?.observers.firstIndex(where: { $0 === observer })
            index.ifPresent { self?.observers.remove(at: $0) }
        }
    }
    
    func start() {
        guard !isEnabled else { return }
        isEnabled = true
        notifyReachable()
        scheduleIfPossible()
    }
    
    func stop() {
        guard isEnabled else { return }
        isEnabled = false
        invalidateTimers()
    }
}

private class ReachabilityObserver {
    weak var value: ReachabilityObserving?
    init(_ value: ReachabilityObserving) {
        self.value = value
    }
}

private func timerFactory(
    timeInterval: TimeInterval,
    repeats: Bool,
    block: @escaping () -> Void) -> Timer
{
    let timer = Timer.scheduledTimer(
        withTimeInterval: timeInterval,
        repeats: repeats,
        block: { _ in block() })
    RunLoop.current.add(timer, forMode: .default)
    return timer
}

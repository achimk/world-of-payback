//
//  JSONFileBasedTransactionItemRepository.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

class JSONFileBasedTransactionItemRepository: TransactionItemRepository {
    
    private enum Const {
        static let fileResource = FileResource(name: "PBTransactions", withExtension: "json")
    }
    
    private let rateLimiter = RateLimiter<FileResource>()
    private let loadAndCache = JSONLoadAndCacheTransformer<TransactionItemsResponse>()
    private let mapResponse: AsyncTransformer<TransactionItemsResponse, [TransactionItem]> = MapTransformer {
        TransactionItemsMapper.map($0)
    }
    private var timeInterval: TimeInterval = 0

    func set(errorCondition: @escaping (Int) -> Bool) {
        rateLimiter.errorCondition = errorCondition
    }
    
    func set(delay timeInterval: TimeInterval) {
        self.timeInterval = timeInterval
    }
    
    func allTransactionItems(completion: @escaping Completion<[TransactionItem]>) -> Cancelable {
        return makeDelay(timeInterval: timeInterval)
            .then(rateLimiter)
            .then(loadAndCache)
            .then(mapResponse)
            .transform(Const.fileResource, completion: completion)
    }
    
    private func makeDelay<T>(timeInterval: TimeInterval) -> AsyncTransformer<T, T> {
        return DelayTransformer(timeInterval: timeInterval)
    }
}

// MARK: - Private

private class RateLimiter<T>: AsyncTransformer<T, T> {
    private let error: Error
    private var counter: Int = 0
    var errorCondition: (Int) -> Bool = { _ in false }
    
    init(error: Error = NSError(domain: "RateLimit", code: 0, userInfo: nil)) {
        self.error = error
    }
    
    override func transform(_ value: T, completion: @escaping Completion<T>) -> Cancelable {
        defer { counter += 1 }
        if errorCondition(counter) {
            completion(.failure(error))
        } else {
            completion(.success(value))
        }
        return NoopCancelable()
    }
}

private class DelayTransformer<T>: AsyncTransformer<T, T> {
    private let timeInterval: TimeInterval
    
    init(timeInterval: TimeInterval = 0) {
        self.timeInterval = max(timeInterval, 0)
    }
    
    override func transform(_ value: T, completion: @escaping Completion<T>) -> Cancelable {
        let onSuccess = { completion(.success(value)) }
        let onFailure = { completion(.failure(NSError(domain: "Canceled", code: 0, userInfo: nil))) }
        return scheduleDispatch(timeInterval: timeInterval, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    private func scheduleDispatch(
        timeInterval: TimeInterval,
        onSuccess: @escaping () -> Void,
        onFailure: @escaping () -> Void) -> Cancelable
    {
        guard timeInterval > 0 else {
            onSuccess()
            return NoopCancelable()
        }
        
        let token = AnyCancelable { }
        DispatchQueue.main.asyncAfter(deadline: .now() + timeInterval, execute: {
            if token.isCanceled {
                onFailure()
            } else {
                onSuccess()
            }
        })
        return token
    }
}

private struct FileResource {
    let name: String
    let withExtension: String
}

private class JSONLoadAndCacheTransformer<T>: AsyncTransformer<FileResource, T> where T: Decodable {
    private var cachedResponse: T?
    
    override func transform(_ value: FileResource, completion: @escaping Completion<T>) -> Cancelable {
        let result = Result(catching: { try loadAndCache(fileResource: value) })
        completion(result)
        return NoopCancelable()
    }
    
    private func loadAndCache(fileResource: FileResource) throws -> T {
        if let cachedResponse = cachedResponse {
            return cachedResponse
        }

        let response = try JSONFileLoader.shared.loadAndDecode(
            type: T.self,
            filename: fileResource.name,
            withExtension: fileResource.withExtension)
        cachedResponse = response
        return response
    }
}

//
//  MapTrasformer.swift
//  async-transform
//
//  Created by Joachim Kret on 25/01/2023.
//

import Foundation

class MapTransformer<Input, Output>: AsyncTransformer<Input, Output> {
    private let transform: AsyncTransformBlock<Input, Output>
    
    init(_ transform: @escaping (Input) throws -> Output) {
        self.transform = { (value, completion) in
            let result = Result(catching: { try transform(value) })
            completion(result)
            return NoopCancelable()
        }
    }
    
    init(_ transform: @escaping AsyncTransformBlock<Input, Output>) {
        self.transform = transform
    }
    
    override func transform(_ value: Input, completion: @escaping Completion<Output>) -> Cancelable {
        return transform(value, completion)
    }
}

//
//  AsyncTransformable+Factories.swift
//  async-transform
//
//  Created by Joachim Kret on 25/01/2023.
//

import Foundation

func make<Input, Output>(_ transform: @escaping (Input) throws -> Output) -> AsyncTransformer<Input, Output> {
    return MapTransformer(transform)
}

func make<Input, Output>(_ transform: @escaping AsyncTransformBlock<Input, Output>) -> AsyncTransformer<Input, Output> {
    return MapTransformer(transform)
}

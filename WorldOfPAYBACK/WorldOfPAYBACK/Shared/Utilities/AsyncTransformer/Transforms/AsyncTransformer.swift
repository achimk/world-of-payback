//
//  AsyncTransformer.swift
//  async-transform
//
//  Created by Joachim Kret on 25/01/2023.
//

import Foundation

class AsyncTransformer<Input, Output>: AsyncTransformable {
    
    func transform(_ value: Input, completion: @escaping Completion<Output>) -> Cancelable {
        abstractMethod()
    }
}

//
//  AsyncTransformBlock.swift
//  async-transform
//
//  Created by Joachim Kret on 25/01/2023.
//

import Foundation

typealias AsyncTransformBlock<Input, Output> = (Input, @escaping Completion<Output>) -> Cancelable

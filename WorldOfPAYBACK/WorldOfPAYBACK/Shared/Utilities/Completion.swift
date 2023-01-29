//
//  Completion.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

typealias Completion<T> = (Result<T, Error>) -> Void

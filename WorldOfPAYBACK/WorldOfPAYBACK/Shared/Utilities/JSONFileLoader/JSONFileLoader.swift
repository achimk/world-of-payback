//
//  JSONFileLoader.swift
//  WorldOfPAYBACK
//
//  Created by Joachim Kret on 29/01/2023.
//

import Foundation

enum JSONFileError: Error {
    case fileNotExists(filename: String, withExtension: String)
    case unableToLoadData(url: URL)
    case failedToDecodeData(data: Data)
}

class JSONFileLoader {
    private let bundle: Bundle
    private let internalDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    static let shared = JSONFileLoader()
    
    init(bundle: Bundle = .currentBundle()) {
        self.bundle = bundle
    }
    
    func loadData(filename: String, withExtension: String = "json") throws -> Data {
        guard let url = bundle.url(forResource: filename, withExtension: withExtension) else {
            throw JSONFileError.fileNotExists(filename: filename, withExtension: withExtension)
        }
        return try loadData(url: url)
    }
    
    func loadData(url: URL) throws -> Data {
        guard let data = try? Data(contentsOf: url) else {
            throw JSONFileError.unableToLoadData(url: url)
        }
        return data
    }
    
    func loadAndDecode<T: Decodable>(type: T.Type, filename: String, withExtension: String = "json") throws -> T {
        let data = try loadData(filename: filename, withExtension: withExtension)
        
        guard let decoded = try? internalDecoder.decode(T.self, from: data) else {
            throw JSONFileError.failedToDecodeData(data: data)
        }
        
        return decoded
    }
}

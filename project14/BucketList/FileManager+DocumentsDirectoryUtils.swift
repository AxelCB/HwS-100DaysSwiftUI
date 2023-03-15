//
//  FileManager+DocumentsDirectoryUtils.swift
//  BucketList
//
//  Created by Axel Collard Bovy on 19/2/23.
//

import Foundation

extension FileManager {
    func writeJSON<T: Codable>(_ content: T, toFile fileName: String) throws {
        let jsonEncoder = JSONEncoder()
        let data = try jsonEncoder.encode(content)
        try data.write(to: getFileURLInDocumentsDirectory(for: fileName))
    }

    func readJSON<T: Codable>(fromFile fileName: String) throws -> T {
        let jsonDecoder = JSONDecoder()
        let data = try Data(contentsOf: getFileURLInDocumentsDirectory(for: fileName))
        return try jsonDecoder.decode(T.self, from: data)
    }

    fileprivate func getFileURLInDocumentsDirectory(for fileName: String) -> URL {
        let paths = Self.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0].appendingPathComponent(fileName)
    }
}

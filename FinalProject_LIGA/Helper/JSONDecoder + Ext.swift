//
//  JSONDecoder.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 01.04.2022.
//

import Foundation

extension JSONDecoder {
    static func decode<T: Decodable>(data: Data) -> T? {
        let jsonDecoder = JSONDecoder()
        do {
            return try jsonDecoder.decode(T.self, from: data)
        } catch {
            print(error)
            return nil
        }
    }
}

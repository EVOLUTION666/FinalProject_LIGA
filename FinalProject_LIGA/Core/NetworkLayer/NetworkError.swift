//
//  NetworkError.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 30.03.2022.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case responseDecodingError
    case responseError
    case statusCodeError
    case dataNotFoundError
}

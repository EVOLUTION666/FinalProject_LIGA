//
//  NetworkSerice.swift
//  FinalProject_LIGA
//
//  Created by Andrey on 01.04.2022.
//

import Foundation

struct DecodeResponse {
    let data: Data
    init (data: Data) {
        self.data = data
    }
    func decodedModel<T: Decodable>() -> T? {
        return JSONDecoder.decode(data: data)
    }
}

class NetworkService {
    
    static func request(urlString: String, headers: [String : String] = [:], completion: @escaping (Result<DecodeResponse, NetworkError>) -> ()) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.allHTTPHeaderFields = headers
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.responseError))
                return
            }
            
            let statusCode = checkStatusCode(statusCode: response.statusCode)
            
            if !statusCode.success {
                completion(.failure(NetworkError.statusCodeError))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.dataNotFoundError))
                return
            }
            
            completion(.success(DecodeResponse.init(data: data)))
            
        }.resume()
    }
    
    static private func checkStatusCode(statusCode: Int) -> (success: Bool, statusCode: Int) {
        switch statusCode {
            case 200...300: return (true, statusCode)
        default:
            return (false, statusCode)
        }
    }
}

//
//  RequestManager.swift
//  LeboncoinTechnicalTest
//
//  Created by hamza on 09/01/2022.
//

import Foundation
import Combine

class RequestManager {
    
    static let shared = RequestManager()
    
    struct Response<T> {
        let value: T
        let response: URLResponse
    }
    
    func get<T: Decodable>(_ type: T.Type, from url: URL, _ decoder: JSONDecoder = JSONDecoder()) -> AnyPublisher<Response<T>, Error> {
        
        return URLSession.shared
            .dataTaskPublisher(for: url)
            .tryMap { result -> Response<T> in
                let value = try decoder.decode(T.self, from: result.data)
                return Response(value: value, response: result.response)
            }
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

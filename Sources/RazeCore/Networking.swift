//
//  File.swift
//  
//
//  Created by Pavel Paddubotski on 9.05.24.
//

import Foundation

protocol NetworkSession {
    func get(from url: URL, completionHandler: @escaping (Data?, (any Error)?) -> Void)
}

extension URLSession: NetworkSession {
    func get(from url: URL, completionHandler: @escaping (Data?, (any Error)?) -> Void) {
        let task = dataTask(with: url) { data, _, error in
            completionHandler(data, error)
        }
        task.resume()
    }
}

extension RazeCore {
    public class Networking {
        /// Responsible for handling all networking calls
        /// - Warning: Must create before using any public APIs
        public class Manager {
            public init() {}
            
            internal var session: NetworkSession = URLSession.shared
            
            /// Calls to the live internet to retrieve Data from a specific location
            /// - Parameters:
            ///   - url: The location you wish to fetch data from
            ///   - completionHandler: Return a result object which signifies the status of the request
            public func loadData(from url: URL, completionHandler: @escaping (Result<Data, Error>) -> Void) {
                session.get(from: url) { data, error in
                    guard let data, error == nil else {
                        completionHandler(.failure(error!))
                        return
                    }
                    completionHandler(.success(data))
                }
            }
        }
    }
}

//
//  File.swift
//  
//
//  Created by Pavel Paddubotski on 9.05.24.
//

import Foundation

extension RazeCore {
    public class Networking {
        /// Responsible for handling all networking calls
        /// - Warning: Must create before using any public APIs
        public class Manager {
            public init() {}
            
            private let session = URLSession.shared
            
            public func loadData(from url: URL, completionHandler: @escaping (Result<Data, Error>) -> Void) {
                let task = session.dataTask(with: url) { data, response, error in
                    guard let data else { return }
                    completionHandler(.success(data))
                }
                task.resume()
            }
        }
    }
}

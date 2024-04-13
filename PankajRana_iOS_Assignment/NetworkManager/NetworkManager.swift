//
//  NetworkManager.swift
//  PankajRana_iOS_Assignment
//
//  Created by Pankaj Rana on 13/04/24.
//

import Foundation

// MARK: - Properties

class NetworkManager {
    static let shared = NetworkManager()
    
    // MARK: - Initializer

    private init() {}
    
    // MARK: - Public Methods

    func fetchImages(page:Int, completion: @escaping (Result<[UnsplashImage], Error>) -> Void) {
        guard let url = URL(string: "\(APIKeys.unsplashAPIURL)?client_id=\(APIKeys.clientID)&order_by=latest&per_page=30&page=\(page)") else {
            completion(.failure(NSError(domain: "URLCreationError", code: 0, userInfo: nil)))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                completion(.failure(NSError(domain: "HTTPResponseError", code: 0, userInfo: nil)))
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "NoDataError", code: 0, userInfo: nil)))
                return
            }
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let images = try decoder.decode([UnsplashImage].self, from: data)
                completion(.success(images))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}


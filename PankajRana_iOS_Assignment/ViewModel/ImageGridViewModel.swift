//
//  ImageGridViewModel.swift
//  PankajRana_iOS_Assignment
//
//  Created by Pankaj Rana on 13/04/24.
//

import Foundation

class ImageGridViewModel {
    // MARK: - Properties

    var images: [UnsplashImage] = []
    
    // MARK: - Public Methods to fetch images from Network Manager.
 
    func fetchImages(page: Int, completion: @escaping (Result<[UnsplashImage], Error>) -> Void) {
        NetworkManager.shared.fetchImages(page:page) { result in
            switch result {
            case .success(let images):
                self.images.append(contentsOf: images)
                completion(.success(images))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

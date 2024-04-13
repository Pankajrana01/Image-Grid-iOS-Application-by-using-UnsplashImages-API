//
//  ImageCell.swift
//  PankajRana_iOS_Assignment
//
//  Created by Pankaj Rana on 13/04/24.
//

import UIKit

class ImageCell: UICollectionViewCell {
    // MARK: - Properties

    static var collectionViewId = "ImageCell"

    // Image view to display the image
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()

    // MARK: - Initializers

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Private Methods to setup imageview.

    private func setupImageView() {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    // MARK: - Public Methods to load image from URL.

    func loadImage(from url: URL) {
        // Use URLSession to fetch the image data from the URL
        URLSession.shared.dataTask(with: url) { data, response, error in
            // Check if there's an error or no data
            guard let data = data, error == nil else {
                print("Failed to load image from URL:", error?.localizedDescription ?? "")
                return
            }

            // Create an image from the data
            if let image = UIImage(data: data) {
                // Update the image view on the main thread
                DispatchQueue.main.async {
                    self.imageView.image = image
                }
            }
        }.resume()
    }
}

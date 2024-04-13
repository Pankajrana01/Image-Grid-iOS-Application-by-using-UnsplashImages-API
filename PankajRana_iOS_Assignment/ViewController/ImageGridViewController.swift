//
//  ImageGridViewController.swift
//  PankajRana_iOS_Assignment
//
//  Created by Pankaj Rana on 13/04/24.
//

import UIKit

class ImageGridViewController: UIViewController {
    // MARK: - Properties
    
    var viewModel = ImageGridViewModel()
    var isLoading = false
    var page = 1
    
    // MARK: - Outlet
    
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.dataSource = self
            collectionView.delegate = self
            collectionView.register(ImageCell.self, forCellWithReuseIdentifier: ImageCell.collectionViewId)
            
            // Setup collection view layout
            let layout = UICollectionViewFlowLayout()
            layout.minimumLineSpacing = 2
            layout.minimumInteritemSpacing = 2
            layout.sectionInset = UIEdgeInsets(top: 5, left: 1, bottom: 5, right: 1)
            collectionView.collectionViewLayout = layout
            
        }
    }
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchImages()
        // Do any additional setup after loading the view.
    }
    
    // MARK: - Private Methods to fetch all images form server.
    
    private func fetchImages() {
        isLoading = true
        viewModel.fetchImages(page: page) { [weak self] result in
            self?.isLoading = false
            switch result {
            case .success(_):
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                print("Error fetching images: \(error)")
            }
        }
    }
    
}

//MARK: - UICollectionViewDelegate, UICollectionViewDataSource

extension ImageGridViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCell", for: indexPath) as? ImageCell {
            cell.loadImage(from: self.viewModel.images[indexPath.row].urls.regularUrl)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastItem = viewModel.images.count - 1
        if indexPath.item == lastItem && !isLoading {
            page += 1
            fetchImages()
        }
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension ImageGridViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat = 5
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize / 2, height: collectionViewSize / 2)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}

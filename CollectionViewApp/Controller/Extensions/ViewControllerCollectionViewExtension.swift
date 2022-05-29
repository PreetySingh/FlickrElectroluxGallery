//
//  ViewControllerCollectionViewExtension.swift
//  CollectionViewApp
//
//  Created by Preety Singh on 28/05/22.
//

import Foundation
import UIKit

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return flickrImages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier,
                                                            for: indexPath) as? FlickrPhotoCell else { return UICollectionViewCell() }
        if let image = flickrImages?[indexPath.row] {
            let imageUrl = "\(image.server)/\(image.id)_\(image.secret)_t.jpg"
            cell.update(with: FlickrPhotoCell.ViewModel.init(imageUrl: imageUrl,
                                                             tag: indexPath.row))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let imageData = flickrImages?[indexPath.row] {
            interactor?.showPhoto(flickrImage: imageData)
        }
    }
}

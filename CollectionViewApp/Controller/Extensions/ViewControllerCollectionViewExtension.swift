//
//  ViewControllerCollectionViewExtension.swift
//  CollectionViewApp
//
//  Created by Preety Singh on 28/05/22.
//

import Foundation
import UIKit

// MARK: Collection View Datasource & Delegate
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader {
            // Initialise Header View
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: Constants.StringConstants.headerViewCellIdentifier,
                                                                             for: indexPath)
            headerView.addSubview(tagSearchBar)
            tagSearchBar.alignToSuperView(superView: headerView)
            return headerView
        } else {
            // Initialise Footer Loading View
            let footerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                             withReuseIdentifier: Constants.StringConstants.footerViewCellIdentifier,
                                                                             for: indexPath)
            let footerBackgroudView = UIView.init(frame: CGRect(x: 0, y: 0, width: collectionView.frame.width, height: 48))
            footerBackgroudView.backgroundColor = .clear
            footerBackgroudView.addSubview(footerActivityIndicator)
            footerView.addSubview(footerBackgroudView)
            footerActivityIndicator.translatesAutoresizingMaskIntoConstraints = false
            footerActivityIndicator.alignToCentre(superView: footerBackgroudView)
            return footerView
        }
    }
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        let contentYoffset = scrollView.contentOffset.y
        let distanceFromBottom = scrollView.contentSize.height - contentYoffset
        if distanceFromBottom < height {
            interactor?.shouldFetchNextPage(pageNumber: currentPageNumber)
        }
    }
}

// MARK: Searchbar Delegate
extension ViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        interactor?.getPhotos(forPage: 1, withTag: searchBar.text)
        searchBar.resignFirstResponder()
    }
}

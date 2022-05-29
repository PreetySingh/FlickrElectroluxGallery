//
//  FlickrPhotoCell.swift
//  CollectionViewApp
//
//  Created by Preety Singh on 28/05/22.
//

import Foundation
import UIKit

protocol Updatable {
    associatedtype ViewModel
    /// Updates UICollectionViewCell with custom view model
    /// - Parameters:
    /// - viewModel: View Model defined by cell
    func update(with viewModel: ViewModel?)
}

class FlickrPhotoCell: UICollectionViewCell, Updatable {
    var imageUrl: String?
    let activityIndicator = UIActivityIndicatorView(style: .large)
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "placeholderImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // Set image view
        photoImageView.frame = frame
        contentView.addSubview(photoImageView)
        photoImageView.alignToSuperView(superView: contentView)
        // Set Cell boarder
        contentView.layer.borderColor = UIColor.lightGray.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 5
        // Add Loading Spinner
        contentView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.alignToCentre(superView: contentView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(with viewModel: ViewModel?) {
        guard let viewModel = viewModel else {
            return
        }
        imageUrl = viewModel.imageUrl
        tag = viewModel.tag
        // Load image from cache if present or else down
        if let image = APIClient.getSharedApiClient().cache.object(forKey: UtilityHelper().getImageUrl(pathUrl:imageUrl) as NSString) {
            photoImageView.image = image
        } else if let imageUrl = imageUrl {
            photoImageView.downloadImage(imageUrl: imageUrl, indicatorDelegate: self)
        }
    }
}

extension FlickrPhotoCell: DownloadIndicatorProtocol {
    func startDownloading() {
        contentView.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func downloadCompleted() {
        activityIndicator.stopAnimating()
        contentView.sendSubviewToBack(activityIndicator)
    }
}

//MARK: FlickrPhotoCell ViewModel
extension FlickrPhotoCell {
    struct ViewModel: Hashable {
        let imageUrl: String
        let tag: Int
    }
}

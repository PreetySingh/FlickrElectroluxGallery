//
//  ImageDetailView.swift
//  CollectionViewApp
//
//  Created by Preety Singh on 29/05/22.
//

import Foundation
import UIKit

protocol FullScreenImageViewProtocol: AnyObject {
    func dismissFullScreenMode()
}

class ImageDetailView: UIView {
    // MARK: - Private Properties
    private weak var fullScreenImageViewDelegate: FullScreenImageViewProtocol?
    private var photoImageUrl: String
    let activityIndicator = UIActivityIndicatorView(style: .large)
    /// Image View
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .white
        imageView.image = UIImage(named: "placeholderImage")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    /// Background View
    private lazy var backgroundView: UIView = {
        let background = UIView()
        background.backgroundColor = UIColor.darkText.withAlphaComponent(0.5)
        background.isUserInteractionEnabled = true
        background.translatesAutoresizingMaskIntoConstraints = false
        return background
    }()
    
    // MARK: - Lifecycle
    init(frame: CGRect, photoImageUrl: String, fullScreenImageViewDelegate: FullScreenImageViewProtocol?) {
        self.photoImageUrl = photoImageUrl
        self.fullScreenImageViewDelegate = fullScreenImageViewDelegate
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupUI() {
        // Set grey background view with tap gesture recognizer
        backgroundColor = .clear
        backgroundView.frame = frame
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissFullScreenMode))
        backgroundView.addGestureRecognizer(tapGestureRecognizer)
        
        // Set loading indicator
        backgroundView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.alignToCentre(superView: backgroundView)
        
        // Set full screen image view
        photoImageView.frame = frame
        backgroundView.addSubview(photoImageView)
        photoImageView.alignToCentre(superView: backgroundView, withMargin: 48)
        
        // Add background view to subview
        addSubview(backgroundView)
        backgroundView.alignToSuperView(superView: self)
    }
    
    func downloadImage() {
        // Use imageView extension too download image using url
        photoImageView.downloadImage(imageUrl: photoImageUrl, indicatorDelegate: self)
    }
    
    /// Dismiss self parent view delegate if present
    @objc func dismissFullScreenMode() {
        fullScreenImageViewDelegate?.dismissFullScreenMode()
    }
}

extension ImageDetailView: DownloadIndicatorProtocol {
    func startDownloading() {
        backgroundView.bringSubviewToFront(activityIndicator)
        activityIndicator.startAnimating()
    }
    
    func downloadCompleted() {
        activityIndicator.stopAnimating()
        backgroundView.sendSubviewToBack(activityIndicator)
    }
}

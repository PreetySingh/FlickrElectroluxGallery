//
//  ViewController.swift
//  CollectionViewApp
//
//  Created by Preety Singh on 26/05/22.
//

import UIKit

protocol DisplayPhotosProtocol: AnyObject {
    /// Show Loading indicator
    func showLoading()
    /// Hide Loading indicator
    func stopLoading()
    /// Show Images in CollectionView
    /// - Parameters:
    /// - images: Array of FlickrModel.PhotoModel to be displayed
    func showImages(images:[FlickrModel.PhotoModel])
    /// Show selected index Image in Full Screen Mode
    /// - Parameters:
    /// - imageView: Full Screen Image View
    func showFullScreenImage(imageView: ImageDetailView)
}

class ViewController: UIViewController {

    let cellIdentifier = "FlickrPhotoCell"
    let activityIndicator = UIActivityIndicatorView(style: .large)
    let interactor: ViewControllerInteractorProtocol?
    var fullScreenView: ImageDetailView?
    var flickrImages: [FlickrModel.PhotoModel]?
    
    // MARK: Private Properties
    private lazy var photoCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: customLayout)
    private lazy var customLayout = CustomCollectionViewLayout.init(screenSize: view.frame.size)
    
    // MARK: Lifecycle
    required init(interactor: ViewControllerInteractorProtocol?) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        interactor?.setDelegate(delegate: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        interactor?.getPhotos(forPage: 1)
        super.viewDidAppear(animated)
    }
    
    /// Setup UI for view
    private func setupUI() {
        // Add CollectionView to View
        view.addSubview(photoCollectionView)
        // Set Datasource & Delegate
        photoCollectionView.delegate = self
        photoCollectionView.dataSource = self
        // Register Cell
        photoCollectionView.register(FlickrPhotoCell.self, forCellWithReuseIdentifier: cellIdentifier)
        // Set Constraints
        photoCollectionView.alignToSuperView(superView: view)
        // Add Loading Spinner
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.alignToCentre(superView: view)
    }
}

extension ViewController: DisplayPhotosProtocol, FullScreenImageViewProtocol {
    func showLoading() {
        activityIndicator.startAnimating()
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
    }
    
    func showImages(images: [FlickrModel.PhotoModel]) {
        stopLoading()
        flickrImages = images
        photoCollectionView.reloadData()
    }
    
    func showFullScreenImage(imageView: ImageDetailView) {
        if fullScreenView == nil {
            view.addSubview(imageView)
            view.bringSubviewToFront(imageView)
            imageView.downloadImage()
            fullScreenView = imageView
        } else {
            dismissFullScreenMode()
        }
    }
    
    func dismissFullScreenMode() {
        fullScreenView?.removeFromSuperview()
        fullScreenView = nil
    }
}




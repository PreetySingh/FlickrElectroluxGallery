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
    /// Set current page number
    /// - Parameters:
    ///    - pageNumber: Latest page number that is rendered on UI
    func setCurrentPageNumber(pageNumber: Int)
}

class ViewController: UIViewController {

    let cellIdentifier = Constants.StringConstants.flickrCellIdentifier
    let activityIndicator = UIActivityIndicatorView(style: .large)
    let footerActivityIndicator = UIActivityIndicatorView(style: .large)
    let interactor: ViewControllerInteractorProtocol?
    var fullScreenView: ImageDetailView?
    var flickrImages: [FlickrModel.PhotoModel]?
    var currentPageNumber: Int = 0
    
    // MARK: Private Properties
    private lazy var photoCollectionView = UICollectionView(frame: view.frame, collectionViewLayout: customLayout)
    private lazy var customLayout = CustomCollectionViewLayout.init(screenSize: view.frame.size)
    lazy var tagSearchBar : UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search tags here..."
        searchBar.delegate = self
        searchBar.tintColor = .lightGray
        searchBar.barTintColor = .white
        searchBar.barStyle = .default
        searchBar.sizeToFit()
        searchBar.showsCancelButton = true
        return searchBar
    }()
    
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
        interactor?.getPhotos(forPage: 1, withTag: nil)
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
        photoCollectionView.register(FlickrPhotoCell.self,
                                     forCellWithReuseIdentifier: cellIdentifier)
        photoCollectionView.register(UICollectionViewCell.self,
                                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                     withReuseIdentifier: Constants.StringConstants.headerViewCellIdentifier)
        photoCollectionView.register(UICollectionViewCell.self,
                                     forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                     withReuseIdentifier: Constants.StringConstants.footerViewCellIdentifier)
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
        if currentPageNumber == 0 {
            activityIndicator.startAnimating()
        } else {
            footerActivityIndicator.startAnimating()
        }
    }
    
    func stopLoading() {
        if currentPageNumber == 0 {
            activityIndicator.stopAnimating()
        } else {
            footerActivityIndicator.stopAnimating()
        }
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
    
    func setCurrentPageNumber(pageNumber: Int) {
        currentPageNumber = pageNumber
    }
}




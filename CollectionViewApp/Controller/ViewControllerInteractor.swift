//
//  ViewControllerInteractor.swift
//  CollectionViewApp
//
//  Created by Preety Singh on 28/05/22.
//

import Foundation

protocol ViewControllerInteractorProtocol {
    /// Get Photo from API of given page
    /// - Parameters:
    ///    - forPage: Page number to be fetched
    ///    - withTag: Search bar text tag to be searched
    func getPhotos(forPage: Int, withTag: String?)
    /// sets delegate of viewController which conforns to DisplayPhotosProtocol
    /// - Parameters:
    /// - delegate: ViewController delegate
    func setDelegate(delegate: DisplayPhotosProtocol?)
    /// show photo of given model
    /// - Parameters:
    /// - flickrImage: Flickr Photo Model data
    func showPhoto(flickrImage: FlickrModel.PhotoModel)
    /// Should fetch next page
    /// - Parameters:
    /// - currentPage: Current page number
    func shouldFetchNextPage(pageNumber: Int)
}

class ViewControllerInteractor: ViewControllerInteractorProtocol {
    // MARK: Private Properties
    private let presenter: ViewControllerPresenterProtocol?
    private let worker: ViewControllerWorkerProtocol?
    private var request: URLRequest?
    private var photosState: ViewControllerPresenter.Result<FlickrModel.Photos, ViewControllerPresenter.GeneralError> {
        didSet {
            presenter?.handlePhotosReceived(photosState)
        }
    }
    weak var setDelegate: DisplayPhotosProtocol? {
        didSet {
            presenter?.setup(controller: setDelegate)
        }
    }
    var totalPages: Int = 0
    var previousSearch: String?
    
    // MARK: Lifecycle
    init(presenter: ViewControllerPresenterProtocol, worker: ViewControllerWorkerProtocol) {
        self.presenter = presenter
        self.worker = worker
        photosState = .defaultState
    }
    
    func setDelegate(delegate: DisplayPhotosProtocol?) {
        setDelegate = delegate
    }
    
    func getPhotos(forPage: Int, withTag: String?) {
        // Set loading state before fetching
        photosState = .loading
        
        // Set search text
        previousSearch = shouldResetSearchResult(withTag: withTag)
        
        // Fetch Photos using worker
        worker?.fetchFlickrImage(tag: previousSearch ?? "", pageNumber: forPage) {
            [weak self] result in
            switch result {
            case .success(let response):
                self?.totalPages = response.photos.pages
                self?.photosState = .success(response)
            case .failure(_):
                self?.photosState = .failure(.requestFailed)
            }
        }
    }
    
    /// Should start a fresh search
    /// - Parameters:
    ///    - withTag: Newly given search tag
    /// - Returns: Final search tag
    func shouldResetSearchResult(withTag: String?) -> String {
        // Set default serach text as "electrolux"
        var searchTag = "electrolux"
        
        // Check whether search text is new or not
        if let userTag = withTag, !userTag.isEmpty, !userTag.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            if previousSearch != userTag {
                totalPages = 0
                presenter?.resetPhotosArray()
            }
            searchTag = userTag
        }
        
        return searchTag
    }
    
    func showPhoto(flickrImage: FlickrModel.PhotoModel) {
        let imageUrl = "\(flickrImage.server)/\(flickrImage.id)_\(flickrImage.secret)_b.jpg"
        presenter?.showFullScreenImage(imageUrl: imageUrl)
    }
    
    func shouldFetchNextPage(pageNumber: Int) {
        if pageNumber < totalPages {
            // Fetch Next Page
            getPhotos(forPage: pageNumber + 1, withTag: previousSearch)
        }
    }
}

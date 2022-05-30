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
        photosState = .loading
        var searchTag = "electrolux"
        if let userTag = withTag, !userTag.isEmpty, !userTag.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            searchTag = userTag
        }
        worker?.fetchFlickrImage(tag: searchTag, pageNumber: forPage) {
            [weak self] result in
            switch result {
            case .success(let response):
                self?.photosState = .success(response)
            case .failure(_):
                self?.photosState = .failure(.requestFailed)
            }
        }
    }
    
    func showPhoto(flickrImage: FlickrModel.PhotoModel) {
        let imageUrl = "\(flickrImage.server)/\(flickrImage.id)_\(flickrImage.secret)_b.jpg"
        presenter?.showFullScreenImage(imageUrl: imageUrl)
    }
}

//
//  ViewControllerPresenter.swift
//  CollectionViewApp
//
//  Created by Preety Singh on 28/05/22.
//

import Foundation
import UIKit

protocol ViewControllerPresenterProtocol {
    /// Setup ViewController delegate to send view related actions
    /// - Parameters:
    /// - controller: ViewController delegate which conforns to DisplayPhotosProtocol
    func setup(controller: DisplayPhotosProtocol?)
    /// Handle API response based upon state and take action
    /// - Parameters:
    /// - state: Response result state whether success or failure
    func handlePhotosReceived(_ state: ViewControllerPresenter.Result<FlickrModel.Photos, ViewControllerPresenter.GeneralError>)
    /// Set Full Screen ImageView on viewController of given Image Url
    /// - Parameters:
    /// - imageUrl: Url to be fetched from server
    func showFullScreenImage(imageUrl: String)
    /// Reset photos array
    func resetPhotosArray()
}

class ViewControllerPresenter: ViewControllerPresenterProtocol {
    weak var controller: DisplayPhotosProtocol?
    var photosArray: [FlickrModel.PhotoModel]?
    func setup(controller: DisplayPhotosProtocol?) {
        self.controller = controller
    }
    
    func handlePhotosReceived(_ state: ViewControllerPresenter.Result<FlickrModel.Photos, ViewControllerPresenter.GeneralError>) {
        switch state {
        case .loading:
            // Show Spinner
            controller?.showLoading()
        case .success(let response):
            // Loading Collection View with images
            controller?.showImages(images: updatePhotosArray(newReponseArray: response.photos.photo))
            controller?.setCurrentPageNumber(pageNumber: response.photos.page)
        default:
            // Stop sinner in case of some failure
            controller?.stopLoading()
        }
    }
    
    func showFullScreenImage(imageUrl: String) {
        let fullScreenImageView = ImageDetailView.init(frame: CGRect(x: 0,
                                                                   y: 0,
                                                                   width: UIScreen.main.bounds.width,
                                                                   height: UIScreen.main.bounds.height),
                                                     photoImageUrl: imageUrl,
                                                     fullScreenImageViewDelegate: controller as? FullScreenImageViewProtocol)
        controller?.showFullScreenImage(imageView: fullScreenImageView)
    }
    
    func resetPhotosArray() {
        photosArray = nil
    }
    
    func updatePhotosArray(newReponseArray: [FlickrModel.PhotoModel]) -> [FlickrModel.PhotoModel] {
        var finalPhotosArray: [FlickrModel.PhotoModel] = photosArray ?? []
        if let currentPhotosArray = photosArray,
            currentPhotosArray.count > 0 {
            newReponseArray.forEach({ (photo) in
                if !currentPhotosArray.contains(photo) {
                    finalPhotosArray.append(photo)
                }
            })
        } else {
            finalPhotosArray = newReponseArray
        }
        photosArray = finalPhotosArray
        return finalPhotosArray
    }
}

// MARK: Embedded types
extension ViewControllerPresenter {
    enum Result<Success, Failure> where Failure: Error {
        /// Data is being loaded asynchronously
        case loading
        /// A success, storing a `Success` value.
        case success(Success)
        /// The `response` contained no data.
        case empty
        /// A failure, storing a `Failure` value.
        case failure(Failure)
        /// Default state
        case defaultState
    }
    
    enum GeneralError: Error {
        case requestFailed
    }
}

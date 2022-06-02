//
//  ViewControllerSpy.swift
//  CollectionViewAppTests
//
//  Created by Preety Singh on 30/05/22.
//

import Foundation
@testable import CollectionViewApp

class ViewControllerSpy: DisplayPhotosProtocol {

    var invokedShowLoading = false
    var invokedShowLoadingCount = 0

    func showLoading() {
        invokedShowLoading = true
        invokedShowLoadingCount += 1
    }

    var invokedStopLoading = false
    var invokedStopLoadingCount = 0

    func stopLoading() {
        invokedStopLoading = true
        invokedStopLoadingCount += 1
    }

    var invokedShowImages = false
    var invokedShowImagesCount = 0
    var invokedShowImagesParameters: (images: [FlickrModel.PhotoModel], Void)?
    var invokedShowImagesParametersList = [(images: [FlickrModel.PhotoModel], Void)]()

    func showImages(images:[FlickrModel.PhotoModel]) {
        invokedShowImages = true
        invokedShowImagesCount += 1
        invokedShowImagesParameters = (images, ())
        invokedShowImagesParametersList.append((images, ()))
    }

    var invokedShowFullScreenImage = false
    var invokedShowFullScreenImageCount = 0
    var invokedShowFullScreenImageParameters: (imageView: ImageDetailView, Void)?
    var invokedShowFullScreenImageParametersList = [(imageView: ImageDetailView, Void)]()

    func showFullScreenImage(imageView: ImageDetailView) {
        invokedShowFullScreenImage = true
        invokedShowFullScreenImageCount += 1
        invokedShowFullScreenImageParameters = (imageView, ())
        invokedShowFullScreenImageParametersList.append((imageView, ()))
    }

    var invokedSetCurrentPageNumber = false
    var invokedSetCurrentPageNumberCount = 0
    var invokedSetCurrentPageNumberParameters: (pageNumber: Int, Void)?
    var invokedSetCurrentPageNumberParametersList = [(pageNumber: Int, Void)]()

    func setCurrentPageNumber(pageNumber: Int) {
        invokedSetCurrentPageNumber = true
        invokedSetCurrentPageNumberCount += 1
        invokedSetCurrentPageNumberParameters = (pageNumber, ())
        invokedSetCurrentPageNumberParametersList.append((pageNumber, ()))
    }
}

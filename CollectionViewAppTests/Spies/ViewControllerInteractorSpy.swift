//
//  ViewControllerInteractorSpy.swift
//  CollectionViewAppTests
//
//  Created by Preety Singh on 30/05/22.
//

import Foundation
@testable import CollectionViewApp

class ViewControllerInteractorSpy: ViewControllerInteractorProtocol {

    var invokedGetPhotos = false
    var invokedGetPhotosCount = 0
    var invokedGetPhotosParameters: (forPage: Int, Void)?
    var invokedGetPhotosParametersList = [(forPage: Int, Void)]()

    func getPhotos(forPage: Int) {
        invokedGetPhotos = true
        invokedGetPhotosCount += 1
        invokedGetPhotosParameters = (forPage, ())
        invokedGetPhotosParametersList.append((forPage, ()))
    }

    var invokedSetDelegate = false
    var invokedSetDelegateCount = 0
    var invokedSetDelegateParameters: (delegate: DisplayPhotosProtocol?, Void)?
    var invokedSetDelegateParametersList = [(delegate: DisplayPhotosProtocol?, Void)]()

    func setDelegate(delegate: DisplayPhotosProtocol?) {
        invokedSetDelegate = true
        invokedSetDelegateCount += 1
        invokedSetDelegateParameters = (delegate, ())
        invokedSetDelegateParametersList.append((delegate, ()))
    }

    var invokedShowPhoto = false
    var invokedShowPhotoCount = 0
    var invokedShowPhotoParameters: (flickrImage: FlickrModel.PhotoModel, Void)?
    var invokedShowPhotoParametersList = [(flickrImage: FlickrModel.PhotoModel, Void)]()

    func showPhoto(flickrImage: FlickrModel.PhotoModel) {
        invokedShowPhoto = true
        invokedShowPhotoCount += 1
        invokedShowPhotoParameters = (flickrImage, ())
        invokedShowPhotoParametersList.append((flickrImage, ()))
    }
}

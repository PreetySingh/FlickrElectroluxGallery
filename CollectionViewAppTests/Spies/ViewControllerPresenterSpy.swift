//
//  ViewControllerPresenterSpy.swift
//  CollectionViewAppTests
//
//  Created by Preety Singh on 30/05/22.
//

import Foundation
@testable import CollectionViewApp

class ViewControllerPresenterSpy: ViewControllerPresenterProtocol {

    var invokedSetup = false
    var invokedSetupCount = 0
    var invokedSetupParameters: (controller: DisplayPhotosProtocol?, Void)?
    var invokedSetupParametersList = [(controller: DisplayPhotosProtocol?, Void)]()

    func setup(controller: DisplayPhotosProtocol?) {
        invokedSetup = true
        invokedSetupCount += 1
        invokedSetupParameters = (controller, ())
        invokedSetupParametersList.append((controller, ()))
    }

    var invokedHandlePhotosReceived = false
    var invokedHandlePhotosReceivedCount = 0
    var invokedHandlePhotosReceivedParameters: (state: ViewControllerPresenter.Result<FlickrModel.Photos, ViewControllerPresenter.GeneralError>, Void)?
    var invokedHandlePhotosReceivedParametersList = [(state: ViewControllerPresenter.Result<FlickrModel.Photos, ViewControllerPresenter.GeneralError>, Void)]()

    func handlePhotosReceived(_ state: ViewControllerPresenter.Result<FlickrModel.Photos, ViewControllerPresenter.GeneralError>) {
        invokedHandlePhotosReceived = true
        invokedHandlePhotosReceivedCount += 1
        invokedHandlePhotosReceivedParameters = (state, ())
        invokedHandlePhotosReceivedParametersList.append((state, ()))
    }

    var invokedShowFullScreenImage = false
    var invokedShowFullScreenImageCount = 0
    var invokedShowFullScreenImageParameters: (imageUrl: String, Void)?
    var invokedShowFullScreenImageParametersList = [(imageUrl: String, Void)]()

    func showFullScreenImage(imageUrl: String) {
        invokedShowFullScreenImage = true
        invokedShowFullScreenImageCount += 1
        invokedShowFullScreenImageParameters = (imageUrl, ())
        invokedShowFullScreenImageParametersList.append((imageUrl, ()))
    }
}

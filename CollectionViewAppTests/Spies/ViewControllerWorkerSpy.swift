//
//  ViewControllerWorkerSpy.swift
//  CollectionViewAppTests
//
//  Created by Preety Singh on 30/05/22.
//

import Foundation
@testable import CollectionViewApp

class ViewControllerWorkerSpy: ViewControllerWorkerProtocol {

    var invokedFetchFlickrImage = false
    var invokedFetchFlickrImageCount = 0
    var invokedFetchFlickrImageParameters: (tag: String, pageNumber: Int)?
    var invokedFetchFlickrImageParametersList = [(tag: String, pageNumber: Int)]()
    var stubbedFetchFlickrImageOnCompletionResult: (Swift.Result<FlickrModel.Photos,ApiError>, Void)?

    func fetchFlickrImage(tag: String, pageNumber: Int, onCompletion: @escaping (Swift.Result<FlickrModel.Photos,ApiError>) -> Void) {
        invokedFetchFlickrImage = true
        invokedFetchFlickrImageCount += 1
        invokedFetchFlickrImageParameters = (tag, pageNumber)
        invokedFetchFlickrImageParametersList.append((tag, pageNumber))
        if let result = stubbedFetchFlickrImageOnCompletionResult {
            onCompletion(result.0)
        }
    }
}

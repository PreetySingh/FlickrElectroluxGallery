//
//  ViewControllerInteractorTests.swift
//  CollectionViewAppTests
//
//  Created by Preety Singh on 30/05/22.
//

import Foundation
import XCTest
@testable import CollectionViewApp

class ViewControllerInteractorTests: XCTestCase {
    func test_fetchImageSearchWithTags_SuccessResponse() {
        // Given
        let presenter = ViewControllerPresenterSpy()
        let worker = ViewControllerWorkerSpy()
        let successResponse = FlickrModel.Photos.create()
        struct EquatableError: Equatable, Error { let message: String }
        worker.stubbedFetchFlickrImageOnCompletionResult = (.success(successResponse),())
        
        let sut = ViewControllerInteractor(presenter: presenter,
                                        worker: worker)
        let result: Result<FlickrModel.Photos?, EquatableError> = .success(successResponse)
        
        // When
        sut.getPhotos(forPage: 1)
        presenter.handlePhotosReceived(.success(successResponse))
        
        // Then
        XCTAssertEqual(result, .success(successResponse))
        XCTAssertEqual(worker.invokedFetchFlickrImageCount, 1)
    }
}

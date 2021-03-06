//
//  ViewControllerTests.swift
//  CollectionViewAppTests
//
//  Created by Preety Singh on 30/05/22.
//

import Foundation
import XCTest
@testable import CollectionViewApp

class ViewControllerTests: XCTestCase {
    func testOnSuccess_CheckPhotoListCount() {
        // Given
        let presenter = ViewControllerPresenter()
        let interactor = ViewControllerInteractorSpy()
        let sut = ViewController(interactor: interactor)
        let successResponse = FlickrModel.Photos.create()
        presenter.setup(controller: sut)
        
        // When
        presenter.handlePhotosReceived(.success(successResponse))
        
        // Then
        XCTAssertEqual(sut.flickrImages?.count ?? 0, 1)
    }
    
    func test_ReachedBottomOfCollectionView_ShouldFetchNextPage() {
        // Given
        let presenter = ViewControllerPresenter()
        presenter.photosArray = [FlickrModel.PhotoModel.createPreviousPagePhoto()]
        let interactor = ViewControllerInteractorSpy()
        let sut = ViewController(interactor: interactor)
        let successResponse = FlickrModel.Photos.create()
        presenter.setup(controller: sut)
        
        // When
        sut.currentPageNumber = 1
        presenter.handlePhotosReceived(.success(successResponse))
        
        // Then
        XCTAssertEqual(sut.flickrImages?.count, 2)
    }
}

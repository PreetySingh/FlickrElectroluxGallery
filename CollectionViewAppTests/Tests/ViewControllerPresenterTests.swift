//
//  ViewControllerPresenterTests.swift
//  CollectionViewAppTests
//
//  Created by Preety Singh on 30/05/22.
//

import Foundation
import XCTest
@testable import CollectionViewApp

class ViewControllerPresenterTests: XCTestCase {
    func testOnSuccess_ShouldCallViewController() {
        // Given
        let sut = ViewControllerPresenter()
        let controller = ViewControllerSpy()
        sut.setup(controller: controller)
        let successResponse = FlickrModel.Photos.create()
        
        // When
        sut.handlePhotosReceived(.success(successResponse))
        
        // Then
        XCTAssertEqual(controller.invokedShowImagesCount,1)
    }
}

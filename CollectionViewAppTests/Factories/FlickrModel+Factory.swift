//
//  FlickrModel+Factory.swift
//  CollectionViewAppTests
//
//  Created by Preety Singh on 30/05/22.
//

import Foundation
@testable import CollectionViewApp

extension FlickrModel.PhotoModel {
    static func create() -> FlickrModel.PhotoModel {
        FlickrModel.PhotoModel(id: "52104449381",
                               owner: "195336741@N02",
                               secret: "702555bfc4",
                               server: "65535",
                               farm: 66,
                               title: "Electrolux Washing Machine",
                               ispublic: 1,
                               isfriend: 0,
                               isfamily: 0,
                               photoUrl: nil)
    }
}

extension FlickrModel.PhotoCollection {
    static func create() -> FlickrModel.PhotoCollection {
        FlickrModel.PhotoCollection(page: 1,
                                    pages: 1,
                                    perpage: 1,
                                    total: 1,
                                    photo: [FlickrModel.PhotoModel.create()])
    }
}

extension FlickrModel.Photos {
    static func create() -> FlickrModel.Photos {
        FlickrModel.Photos(photos: FlickrModel.PhotoCollection.create(),
                           stat: "ok")
    }
}

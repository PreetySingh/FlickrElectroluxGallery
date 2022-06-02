//
//  FlickrModel.swift
//  CollectionViewApp
//
//  Created by Preety Singh on 28/05/22.
//

import Foundation

// MARK: - Flickr Data Models
struct FlickrModel: Codable, Equatable, Hashable {
    
    struct Photos: Codable, Equatable {
        let photos: PhotoCollection
        let stat: String
    }
    
    // MARK: - Photos Collection Model
    struct PhotoCollection: Codable,Equatable {
        let page: Int
        let pages: Int
        let perpage: Int
        let total: Int
        let photo: [PhotoModel]
    }
    
    // MARK: - Photo Model
    struct PhotoModel: Codable,Equatable, Hashable {
        let id: String
        let owner: String
        let secret: String
        let server: String
        let farm: Int
        let title: String
        let ispublic: Int
        let isfriend: Int
        let isfamily: Int
        let photoUrl: String?
    }
}

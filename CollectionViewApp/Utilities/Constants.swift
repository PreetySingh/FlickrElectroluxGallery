//
//  Constants.swift
//  CollectionViewApp
//
//  Created by Preety Singh on 27/05/22.
//

import Foundation

struct Constants {
    static let appAPIKey = "4ca339356b476b490d2a3c48aacd3276"
    static let urlScheme = "https"
    static let baseUrl = "api.flickr.com/"
    static let pathUrl = "services/rest"
    
    struct URLS {
        static let searchUsingHashtagUrl = "https://api.flickr.com/services/rest?method=flickr.photos.search&api_key=\(Constants.appAPIKey)&per_page=21&format=json&nojsoncallback=1"
        static let downloadImageBaseUrl = "https://live.staticflickr.com/"
    }
}

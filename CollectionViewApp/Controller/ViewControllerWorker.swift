//
//  ViewControllerWorker.swift
//  CollectionViewApp
//
//  Created by Preety Singh on 28/05/22.
//

import Foundation

protocol ViewControllerWorkerProtocol {
    func fetchFlickrImage(tag: String, pageNumber: Int, onCompletion: @escaping (Swift.Result<FlickrModel.Photos,ApiError>) -> Void)
}

class ViewControllerWorker: ViewControllerWorkerProtocol {
    // MARK: Private properties
    private let apiClient: APIClient
    
    // MARK: Lifecycle
    init(apiClient: APIClient = APIClient.getSharedApiClient()) {
        self.apiClient = apiClient
    }
    
    func fetchFlickrImage(tag: String, pageNumber: Int, onCompletion: @escaping (Swift.Result<FlickrModel.Photos,ApiError>) -> Void) {
        let baseURL = Constants.URLS.searchUsingHashtagUrl
        let urlString = "\(baseURL)&tags=\(tag)&page=\(pageNumber)"
        return apiClient.getRequest(stringURL: urlString,
                                    type: FlickrModel.Photos.self,
                                    completion: { onCompletion($0) })
    }
}

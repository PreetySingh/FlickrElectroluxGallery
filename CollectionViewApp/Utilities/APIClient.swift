//
//  APIClient.swift
//  CollectionViewApp
//
//  Created by Preety Singh on 26/05/22.
//

import Foundation
import UIKit

// MARK: API Error Types
public enum ApiError: Error, CustomStringConvertible, Equatable {
    case badUrl
    case invalidResponse
    case malformedData
    case customError(message: String)
    
    public var description: String {
        switch self {
        case .badUrl: return "Bad URL"
        case .invalidResponse: return "Invalid response received from service"
        case .malformedData: return "Malformed data received from service"
        case .customError(message: let message): return message
        }
    }
}

class APIClient: NSObject {
    static var sharedApiClient: APIClient = {
        let apiClient = APIClient()
        return apiClient
    }()
    let cache = NSCache<NSString, UIImage>()
    public class func getSharedApiClient() -> APIClient {
        sharedApiClient
    }
    let configuration = URLSessionConfiguration.default
    
    func getRequest<T: Decodable>(stringURL: String, type: T.Type, completion: @escaping (Result<T, ApiError>) -> Void) {
        guard let url = URL(string: stringURL) else {
            completion(.failure(.badUrl))
            return
        }
        // Execute Get request
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
        session.dataTask(with: url) {
            data, response, error in
            
            if let error = error {
                completion(.failure(.customError(message: "\(error)")))
            } else if let data = data {
                do {
                    let result = try JSONDecoder().decode(type, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(.malformedData))
                }
            } else {
                completion(.failure(.invalidResponse))
            }
        }.resume()
    }
    
    func downloadImage(stringURL: String, completion: @escaping (UIImage?) -> Void) {
        // Create cache key
        let cacheKey = NSString(string: stringURL)
        // Called after download is completed to cache image
        if let image = cache.object(forKey: cacheKey) {
            completion(image)
            return
        }
        guard let url = URL(string: stringURL) else {
            completion(nil)
            return
        }
        // Download image using given url
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue:OperationQueue.main)
        session.dataTask(with: url) { [weak self] data, response, error in
            guard let self = self,
                  error == nil,
                  let response = response as? HTTPURLResponse, response.statusCode == 200,
                  let data = data,
                  let image = UIImage(data: data) else {
                completion(nil)
                return
            }
            self.cache.setObject(image, forKey: cacheKey)
            completion(image)
        }.resume()
    }
}
    
extension APIClient: URLSessionDelegate {
    /// Ignores even if SSL certificate not available allows API execution
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
            completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!) )
        }
}

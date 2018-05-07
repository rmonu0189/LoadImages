//
//  NetworkDataManager.swift
//  Assignment
//
//  Created by Monu on 06/05/18.
//  Copyright © 2018 Monu. All rights reserved.
//

import Foundation
import UIKit

class NetworkDataManager {
    
    /**
     Check wheather network is reachable.
     */
    class func isNetworkReachable() -> Bool {
        let reach: Reachability = Reachability.forInternetConnection()
        return reach.currentReachabilityStatus().rawValue != NotReachable.rawValue
    }
    
    /**
     Fetch results from server.
     */
    class func fetchResults<T>(type: T.Type, service: APIService, handler: @escaping (_ result: [T]?, _ error: Error?) -> ()) {
        if let request = createRequestFromService(service) {
            NetworkConnection.shared.performRequest(request, completion: { (connectionData, connectionError) in
                if let data = connectionData {
                    do {
                        let jsonDecoder = JSONDecoder()
                        let decodedObjects = try jsonDecoder.decode([T].self, from: data)
                        handler(decodedObjects, nil)
                    } catch let error {
                        handler(nil, error)
                    }
                } else {
                    handler(nil, connectionError)
                }
            })
        } else {
            handler(nil, generateInvalidError())
        }
    }
    
    /**
     Fetch results from server.
     */
    class func downloadImageFromURL(_ url: URL, handler: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        let request = URLRequest(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 60.0)
        NetworkConnection.shared.performRequest(request) { (data, error) in
            if let connectionData = data, let image = UIImage(data: connectionData) {
                NetworkConnection.shared.imageCache.saveImage(image, forKey: url.absoluteString)
                handler(image, nil)
            } else {
                handler(nil, error)
            }
        }
    }
    
    /**
     Download image from cache
     */
    class func imageFromCacheWithUrl(_ url: String) -> UIImage? {
        return NetworkConnection.shared.imageCache.imageFromCacheForKey(url)
    }
    
    /**
     Cancel request
     */
    class func cancelRequestFromUrl(_ stringUrl: String?) {
        if let apiUrl = stringUrl, let url = URL(string: apiUrl) {
            NetworkConnection.shared.cancelRequestForURL(url)
        }
    }
    
}

extension NetworkDataManager {
    
    // MARK: - Create Request

    fileprivate class func createRequestFromService(_ service: APIService, isCache: Bool = false) -> URLRequest? {
        if service.method == .GET {
            var components = URLComponents(string: service.apiURL)
            components?.queryItems = queryItems(service.parameters)
            if let url = components?.url {
                var request = URLRequest(url: url)
                request.timeoutInterval = 60.0
                request.httpMethod = service.method.rawValue
                if isCache { request.cachePolicy = .returnCacheDataElseLoad }
                return request
            }
        }
        return nil
    }
    
    fileprivate class func queryItems(_ params: [String: Any]) -> [URLQueryItem]? {
        var items = [URLQueryItem]()
        for key in params.keys {
            if params[key] is String {
                items.append(URLQueryItem(name: key, value: params[key] as? String))
            }
        }
        return items
    }
    
    fileprivate class func generateInvalidError() -> Error {
        let error = NSError(domain: "INVALID_REQUEST", code: 0, userInfo: [NSLocalizedDescriptionKey: NSLocalizedString("Invalid request", comment: "Invalid request")])
        return error as Error
    }
    
}

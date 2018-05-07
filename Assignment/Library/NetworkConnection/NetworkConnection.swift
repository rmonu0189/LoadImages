//
//  NetworkConnection.swift
//  Assignment
//
//  Created by Monu on 06/05/18.
//  Copyright © 2018 Monu. All rights reserved.
//

import Foundation
import UIKit

final class NetworkConnection {
    
    var imageCache: ImageCache!
    fileprivate var urlSession: URLSession!
    
    // MARK: - Singleton Instance
    
    class var shared: NetworkConnection {
        struct Singleton {
            static let instance = NetworkConnection()
        }
        return Singleton.instance
    }
    
    // MARK: - Initialization
    
    fileprivate init() {
        // customize initialization
        urlSession = URLSession(configuration: URLSessionConfiguration.default)
        imageCache = ImageCache()
    }
    
    // MARK: - Public methods
    
    func performRequest(_ request: URLRequest, completion: @escaping (_ data: Data?,_ error: Error?) -> Void) {
        self.urlSession.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let httpResponse = response as? HTTPURLResponse {
                    if httpResponse.statusCode > 299 {
                        let error = NSError(domain: "HTTP_STATUS_ERROR", code: httpResponse.statusCode, userInfo: [NSLocalizedDescriptionKey: NSLocalizedString("HTTP status error", comment: "HTTP status error")])
                        completion(nil, error as Error); return
                    } else {
                        completion(data, nil)
                    }
                } else {
                    let error = NSError(domain: "UNKNOWN_ERROR", code: 0, userInfo: [NSLocalizedDescriptionKey: NSLocalizedString("Unknown error", comment: "Unknown error")])
                    completion(nil, error as Error); return
                }
            }
        }.resume()
    }
    
    /**
     Cancel url request.
     */
    func cancelRequestForURL(_ url: URL) {
        urlSession.getTasksWithCompletionHandler({ (dataTasks: [URLSessionDataTask], uploadTasks: [URLSessionUploadTask], downloadTasks: [URLSessionDownloadTask]) -> Void in
            
            let capacity: NSInteger = dataTasks.count + uploadTasks.count + downloadTasks.count
            let tasks: NSMutableArray = NSMutableArray(capacity: capacity)
            tasks.addObjects(from: dataTasks)
            tasks.addObjects(from: uploadTasks)
            tasks.addObjects(from: downloadTasks)
            
            for task in tasks {
                if let cancelTask = task as? URLSessionTask {
                    if cancelTask.originalRequest?.url?.absoluteString == url.absoluteString {
                        cancelTask.cancel()
                    }
                }
            }
        })
    }

}

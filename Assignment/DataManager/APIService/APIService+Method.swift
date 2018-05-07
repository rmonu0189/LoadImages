//
//  APIService+Method.swift
//  Assignment
//
//  Created by Monu on 06/05/18.
//  Copyright © 2018 Monu. All rights reserved.
//

import Foundation

// MARK: - Service methods

extension APIService {
    
    var method: HTTPRequestMethod {
        switch self {
        case .fetchPictures:
            return .GET
        }
    }
    
}

// MARK: - Supported HTTP request methods

enum HTTPRequestMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

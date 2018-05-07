//
//  APIService+URL.swift
//  Assignment
//
//  Created by Monu on 06/05/18.
//  Copyright © 2018 Monu. All rights reserved.
//

import Foundation

// MARK: - Server url

extension APIService {
    
    var apiURL: String {
        return Constant.baseUrl + path
    }
    
    // Put all end points with corresponding case.
    private var path: String {
        switch self {
        case .fetchPictures:
            return "api/assignment"
        }
    }
    
}

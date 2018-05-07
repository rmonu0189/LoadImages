//
//  APIService+Parameter.swift
//  Assignment
//
//  Created by Monu on 06/05/18.
//  Copyright © 2018 Monu. All rights reserved.
//

import Foundation

// MARK: - Service parameters

extension APIService {
    
    var parameters: [String: Any] {
        switch self {
        case .fetchPictures:
            return [:]
        }
    }
    
}

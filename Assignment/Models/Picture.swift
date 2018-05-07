//
//  Picture.swift
//  Assignment
//
//  Created by Monu on 05/05/18.
//  Copyright © 2018 Monu. All rights reserved.
//

import UIKit

class Picture: NSObject, Codable {

    var name: String?
    var email: String?
    var image: String?
    var created_at: String?
    
    func createLocalEntry() -> LocalPicture {
        let photo = LocalPicture(context: CoreDataManager.shared.defaultContext)
        photo.name = self.name
        photo.email = self.email
        photo.image = self.image
        photo.created_at = self.created_at
        return photo
    }
    
}

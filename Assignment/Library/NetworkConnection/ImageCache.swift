//
//  ImageCache.swift
//  Assignment
//
//  Created by Monu on 07/05/18.
//  Copyright © 2018 Monu. All rights reserved.
//

import Foundation
import UIKit

class ImageCache {
    
    let imageCache = NSCache<NSString, UIImage>()
    
    func saveImage(_ image: UIImage, forKey: String) {
        self.imageCache.setObject(image, forKey: forKey as NSString)
    }
    
    func imageFromCacheForKey(_ key: String) -> UIImage? {
        return self.imageCache.object(forKey: key as NSString)
    }
    
}

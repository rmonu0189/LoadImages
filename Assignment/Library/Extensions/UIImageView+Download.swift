//
//  UIImageView+Download.swift
//  Assignment
//
//  Created by Monu on 07/05/18.
//  Copyright © 2018 Monu. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    // MARK: - Public methods
    
    // Download image from url or cache
    func imageFromURL(_ url: String?, placeholder: UIImage, handler: @escaping (_ image: UIImage?) -> Void) {
        if let imageUrl = url {
            if let image = imageFromCache(imageUrl) {
                self.image = image
            } else {
                self.image = placeholder
                downloadImageFromURL(imageUrl, handler: handler)
            }
        } else {
            self.image = placeholder
        }
    }
    
    // MARK: - Private methds
    
    // Download image from url
    fileprivate func downloadImageFromURL(_ url: String, handler: @escaping (_ image: UIImage?) -> Void) {
        if let imageUrl = URL(string: url) {
            NetworkDataManager.downloadImageFromURL(imageUrl, handler: { (connectionImage, error) in
                if let connectionImage = connectionImage {
                    DispatchQueue.main.async {
                        handler(connectionImage)
                    }
                }
            })
        }
    }
    
    // Download image from cache
    fileprivate func imageFromCache(_ url: String) -> UIImage? {
        return NetworkDataManager.imageFromCacheWithUrl(url)
    }
    
}

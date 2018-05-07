//
//  AppLoader.swift
//
//  Created by Monu on 23/04/18.
//  Copyright © 2018 Monu. All rights reserved.
//

import Foundation

class AppLoader {
    
    class func show() {
        if Thread.isMainThread {
            AppLoaderView.sharedInstance.showLoader()
        } else {
            DispatchQueue.main.async {
                AppLoaderView.sharedInstance.showLoader()
            }
        }
    }
    
    class func hide() {
        if Thread.isMainThread {
            AppLoaderView.sharedInstance.hideLoader()
        } else {
            DispatchQueue.main.async {
                AppLoaderView.sharedInstance.hideLoader()
            }
        }
    }
    
}

//
//  AppLoaderView.swift
//
//  Created by Monu on 09/01/18.
//  Copyright © 2018 Appster. All rights reserved.
//

import UIKit

class AppLoaderView: UIView {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    private class func instanceFromNib() -> AppLoaderView {
        return UINib(nibName: String(describing: self), bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! AppLoaderView
    }

    // MARK: - Singleton Instance
    class var sharedInstance: AppLoaderView {
        struct Singleton {
            static let instance = AppLoaderView.instanceFromNib()
        }
        Singleton.instance.shadowOnView()
        return Singleton.instance
    }

    private func shadowOnView() {
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 5.0
        layer.shadowColor = UIColor(red: 39.0/255.0, green: 66.0/255.0, blue: 107.0/255.0, alpha: 0.3).cgColor
        layer.shadowOpacity = 2.5
    }

    public func showLoader() {
        if let app = UIApplication.shared.delegate as? AppDelegate, let window = app.window {
            UIApplication.shared.endIgnoringInteractionEvents()
            UIApplication.shared.beginIgnoringInteractionEvents()
            let loader = AppLoaderView.sharedInstance
            loader.indicator.startAnimating()
            loader.center = window.center
            if loader.superview == nil {
                window.addSubview(loader)
            }
        }
    }

    public func hideLoader() {
        UIApplication.shared.endIgnoringInteractionEvents()
        let loader = AppLoaderView.sharedInstance
        loader.indicator.stopAnimating()
        loader.removeFromSuperview()
    }
}

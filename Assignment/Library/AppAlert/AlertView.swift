//
//  AlertView.swift
//
//  Created by Monu on 20/10/17.
//  Copyright © 2017 Appster. All rights reserved.
//

import UIKit

class AlertView: UIView {

    @IBOutlet weak var messageLabel: UILabel!

    // MARK: - AlertView configuration
    fileprivate var displayTime = 2.0
    fileprivate static var errorColor: UIColor? = UIColor(red: 255.0 / 255.0, green: 117.0 / 255.0, blue: 73.0 / 255.0, alpha: 1.0)
    fileprivate static var successColor: UIColor? = UIColor(red: 46.0 / 255.0, green: 214.0 / 255.0, blue: 132.0 / 255.0, alpha: 1.0)

    private class func instanceFromNib() -> AlertView? {
        return UINib(nibName: String(describing: self), bundle: nil).instantiate(withOwner: nil, options: nil)[0] as? AlertView
    }

    // MARK: - Show / Hide alert
    public class func showMessage(_ message: String, isError: Bool) {
        if let alert = AlertView.instanceFromNib() {
            alert.frame.size.width = UIScreen.main.bounds.width
            alert.frame.origin.y = -alert.frame.height
            alert.frame.size.height = UIScreen.main.bounds.height == 812 ? 84 : 64
            alert.messageLabel.text = message
            alert.backgroundColor = isError ? errorColor : successColor
            alert.showWithAnimation(true)
        }
    }

    private func showWithAnimation(_ animation: Bool) {
        DispatchQueue.main.async {
            self.appDelegate().window?.addSubview(self)
            if animation {
                UIView.animate(withDuration: 0.3, animations: {
                    self.frame.origin.y = 0
                }) { _ in
                    self.perform(#selector(AlertView.hideWithAnimation), with: nil, afterDelay: self.displayTime)
                }
            } else {
                self.frame.origin.y = 0
            }
        }
    }

    @objc func hideWithAnimation() {
        UIView.animate(withDuration: 0.3, animations: {
            self.frame.origin.y = -self.frame.height
        }, completion: { _ in
            self.removeFromSuperview()
        })
    }

    // MARK: - IBAction methods
    @IBAction func closeTapped(_: Any) {
        hideWithAnimation()
    }
    
    // MARK: - App Delegate Ref
    func appDelegate() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}

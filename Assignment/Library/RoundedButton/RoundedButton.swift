//
//  RoundedButton.swift
//
//  Created by Monu on 12/04/18.
//  Copyright © 2018 Monu. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    fileprivate let radius: CGFloat = 5.0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupRoundedButton()
        self.dropShadow()
    }
    
    // MARK: - Private Helpers
    private func setupRoundedButton() {
        self.layer.cornerRadius = radius
    }
    
    // MARK: - Public Helpers
    public func borderButtonWithColor(_ color: UIColor) {
        self.layer.cornerRadius = radius
        self.layer.borderWidth = 2.0
        self.layer.borderColor = color.cgColor
        self.backgroundColor = UIColor.clear
        self.setTitleColor(color, for: .normal)
    }
    
    private func dropShadow() {
        self.layer.shadowColor = UIColor(red: 5.0/255.0, green: 132.0/255.0, blue: 232.0/255.0, alpha: 0.1).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 8.0)
        self.layer.shadowOpacity = 6.0
        self.layer.shadowRadius = 2.0
        self.layer.masksToBounds = false
    }

}

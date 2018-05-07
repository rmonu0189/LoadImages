//
//  HorizontalListCell.swift
//  Assignment
//
//  Created by Monu on 06/05/18.
//  Copyright © 2018 Monu. All rights reserved.
//

import UIKit

class HorizontalListCell: UICollectionViewCell {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    
    // MARK: - Public methods
    
    func configurePicture(_ picture: LocalPicture) {
        self.nameLabel.text = picture.name
        self.emailLabel.text = picture.email
        self.dateTimeLabel.text = picture.created_at
        
        if let imageUrl = picture.image {
            self.userImageView.sd_setShowActivityIndicatorView(true)
            self.userImageView.sd_setIndicatorStyle(.white)
            self.userImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: nil)
        } else {
            self.userImageView.image = nil
        }
    }
    
}

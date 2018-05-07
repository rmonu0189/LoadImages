//
//  PictureTableViewCell.swift
//  Assignment
//
//  Created by Monu on 05/05/18.
//  Copyright © 2018 Monu. All rights reserved.
//

import UIKit

class PictureTableViewCell: UITableViewCell {

    // MARK: - IBOutlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var dateTimeLabel: UILabel!
    @IBOutlet weak var userImageView: UIImageView!
    
    // MARK: - UITableViewCell override methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.setupCell()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    // MARK: - Private methods
    
    private func setupCell() {
        self.userImageView.layer.cornerRadius = self.userImageView.frame.height / 2
    }
    
    // MARK: - Public methods
    
    func configurePicture(_ picture: LocalPicture) {
        self.nameLabel.text = picture.name
        self.emailLabel.text = picture.email
        self.dateTimeLabel.text = picture.created_at
        
        if let imageUrl = picture.image {
            self.userImageView.sd_setShowActivityIndicatorView(true)
            self.userImageView.sd_setIndicatorStyle(.gray)
            self.userImageView.sd_setImage(with: URL(string: imageUrl), placeholderImage: #imageLiteral(resourceName: "icPlaceholder"))
        } else {
            self.userImageView.image = #imageLiteral(resourceName: "icPlaceholder")
        }
    }
    
}

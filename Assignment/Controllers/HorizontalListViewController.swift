//
//  HorizontalListViewController.swift
//  Assignment
//
//  Created by Monu on 06/05/18.
//  Copyright © 2018 Monu. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class HorizontalListViewController: UICollectionViewController {

    // MARK: - Properties
    
    var pictures: [LocalPicture] = [LocalPicture]()
    
    // MARK: - UIViewController life cycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fetchPictures()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.pictures.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! HorizontalListCell
        let picture = self.pictures[indexPath.item]
        cell.configurePicture(picture)
        return cell
    }
    
    // MARK: - API Services
    
    private func fetchPictures() {
        AppLoader.show()
        LocalPicture.fetchAllWithHandler { (records, error) in
            AppLoader.hide()
            if let pictures = records {
                self.pictures = pictures
                self.collectionView?.reloadData()
            } else {
                AppAlert.showError(error)
            }
        }
    }

}

extension HorizontalListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout _: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = UIScreen.main.bounds.size.height - (self.navigationController?.navigationBar.frame.height ?? 64)
        return CGSize(width: collectionView.frame.size.width, height: height)
    }
    
}

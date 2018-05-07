//
//  Picture+Service.swift
//  Assignment
//
//  Created by Monu on 06/05/18.
//  Copyright © 2018 Monu. All rights reserved.
//

import Foundation

extension LocalPicture {
    
    // Fetch pictures from server / local database
    class func fetchAllWithHandler(_ handler: @escaping (_ pictures: [LocalPicture]?,_ error: Error?) -> Void) {
        if NetworkDataManager.isNetworkReachable() {
            NetworkDataManager.fetchResults(type: Picture.self, service: APIService.fetchPictures) { (records, error) in
                if let pictures = records {
                    // Save records in local Database.
                    let photos = saveInToLocalDataBase(pictures)
                    handler(photos, nil)
                } else {
                    handler(nil , error)
                }
            }
        } else {
            // Fetch records from local Database.
            let photos = LocalPicture.fetch(type: LocalPicture.self)
            handler(photos, nil)
        }
    }
    
    private class func saveInToLocalDataBase(_ pictures: [Picture]) -> [LocalPicture] {
        LocalPicture.removeAll(type: LocalPicture.self)
        let localEntry = pictures.flatMap({$0.createLocalEntry()})
        CoreDataManager.shared.saveContext()
        return localEntry
    }
    
}

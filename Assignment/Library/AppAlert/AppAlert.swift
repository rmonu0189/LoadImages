//
//  AppAlert.swift
//
//  Created by Monu on 20/10/17.
//  Copyright © 2017 Appster. All rights reserved.
//

import Foundation

class AppAlert {

    public class func showSuccess(_ message: String) {
        if !message.isEmpty {
            DispatchQueue.main.async {
                AlertView.showMessage(message, isError: false)
            }
        }
    }

    public class func showError(_ message: String) {
        var errorMessage = ""
        if message.lowercased().contains("server with hostname could not") {
            errorMessage = "Something went wrong"
        } else if !message.isEmpty, !(message == "cancelled") {
            errorMessage = message
        }
        DispatchQueue.main.async {
            AlertView.showMessage(errorMessage, isError: true)
        }
    }

    public class func showError(_ error: Error?) {
        if let errorMessage = error, !errorMessage.localizedDescription.isEmpty, !(errorMessage.localizedDescription == "cancelled") {
            DispatchQueue.main.async {
                AppAlert.showError(errorMessage.localizedDescription)
            }
        }
    }
}

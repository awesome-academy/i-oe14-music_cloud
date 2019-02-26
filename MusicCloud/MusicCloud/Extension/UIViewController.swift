//
//  ErrorResponse.swift
//  MusicCloud
//
//  Created by thanh on 2/26/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

extension UIViewController {
    func showAlertView(title: String?, message: String?, cancelButton: String?, otherButtons: [String]? = nil,
                       type: UIAlertController.Style = .alert, cancelAction: (() -> Void)? = nil,
                       otherAction: ((Int) -> Void)? = nil) {
        let alertViewController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
        if let cancelButton = cancelButton {
            let cancelAction = UIAlertAction(title: cancelButton, style: .cancel, handler: { (_) in
                cancelAction?()
            })
            alertViewController.addAction(cancelAction)
        }
        if let otherButtons = otherButtons {
            for (index, otherButton) in otherButtons.enumerated() {
                let otherAction = UIAlertAction(title: otherButton,
                                                style: .default, handler: { (_) in
                                                    otherAction?(index)
                })
                alertViewController.addAction(otherAction)
            }
        }
        self.present(alertViewController, animated: true, completion: nil)
    }
    
    func showErrorAlert(message: String?) {
        showAlertView(title: "Error", message: message, cancelButton: "OK")
    }
}


//
//  ShowMessage.swift
//  Cryptopy
//
//  Created by Ceren Yaşa on 11.06.2022.
//

import Foundation
import UIKit

// Show alert to user
func showMessage(title: String, text: String, isJustConfirm: Bool = false) {
    let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: Strings.ok, style: .default, handler: nil))
    if isJustConfirm{
        alert.addAction(UIAlertAction(title: Strings.cancel, style: .cancel, handler: nil))
    }
    
    SceneDelegate().window?.rootViewController?.present(alert, animated: true, completion: nil)
}

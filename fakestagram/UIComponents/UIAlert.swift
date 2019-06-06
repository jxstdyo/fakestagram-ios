//
//  UIAlert+message.swift
//  fakestagram
//
//  Created by Antonyo Chavez Saucedo on 5/17/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

class UIAlert{
    static func showMessage(showIn : UIViewController, message : String){
        let alert  = UIAlertController(title: "Warning", message:message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        showIn.self.present(alert, animated: true, completion: nil)
    }
    
    
    
    static func show(showIn : UIViewController, title : String, placeholder : String, success: @escaping (String) -> Void) {
        var usernameTextField: UITextField?
        let alert = UIAlertController(
            title: title,
            message: "",
            preferredStyle: .alert)
        let loginAction = UIAlertAction(title: "Enviar", style: .default) {(action) -> Void in
            if let username = usernameTextField?.text {
                usernameTextField!.endEditing(true)
                success(username)
            } else {
                print("No Text")
            }
        }
        
        alert.addTextField {
            (txtUsername) -> Void in
            usernameTextField = txtUsername
            usernameTextField!.placeholder = placeholder
        }
        
        // 5.
        alert.addAction(UIAlertAction(title: "Cancelar", style: .destructive, handler: nil))
        alert.addAction(loginAction)
        showIn.self.present(alert, animated: true, completion: nil)
        
    }
    
}



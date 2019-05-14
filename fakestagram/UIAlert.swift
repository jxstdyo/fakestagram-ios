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
}



//
//  UIImage+Encode.swift
//  fakestagram
//
//  Created by Antonyo Chavez Saucedo on 4/27/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

extension UIImage{
    func encodedBase64() -> String? {
        guard let jpg = self.jpegData(compressionQuality: 0.95) else { return nil}
        return "data:image/jpeg;base64,\(jpg.base64EncodedString(options: .lineLength64Characters))"
    }

}

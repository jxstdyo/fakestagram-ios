//
//  ImageStore.swift
//  fakestagram
//
//  Created by Antonyo Chavez Saucedo on 4/26/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

struct ImageStorage {
    let filename : String
    
    let dataContainer = DataContainer.permanent
    
    func load() -> UIImage? {
        guard let data = dataContainer.load(filename : filename) else {
            return nil
        }
        return UIImage(data: data)
    }
    
    func save(image : UIImage) -> Bool {
        //Utiliza menos espacion en disco JPEG que PNG
        guard let data = image.jpegData(compressionQuality: 0.95) else {
            print("Unable to load jpeg data representation")
            return false
        }
        return dataContainer.save(data : data, filename : filename)
    }
    
}

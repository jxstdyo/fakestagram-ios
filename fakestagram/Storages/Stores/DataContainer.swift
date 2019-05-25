//
//  DataStore.swift
//  fakestagram
//
//  Created by Antonyo Chavez Saucedo on 4/26/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

enum DataContainer {
    
    case permanent
    case cache
    
    var baseUrl : URL{
        switch self {
        case .cache:
            return StorageType.cache.url
        case .permanent:
            return StorageType.permanent.url
        }
    }
    
    func fileUrl(for filename : String) -> URL? {
        var fileUrl = baseUrl
        fileUrl.appendPathComponent(filename)
        return fileUrl
    }
    
    func load(filename : String) -> Data? {
        guard let url = fileUrl(for: filename) else {
            return nil
        }
        return try? Data(contentsOf: url)
    }
    
    func save(data : Data, filename : String) -> Bool {
        guard let url = fileUrl(for: filename) else {
            return false
        }
        do {
            try data.write(to: url)
            return true
        } catch let err {
            print("Unable to write on disk: \(err.localizedDescription)")
            return false
        }
    }
    
}

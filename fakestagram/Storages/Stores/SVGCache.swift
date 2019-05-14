//
//  DataCache.swift
//  fakestagram
//
//  Created by Antonyo Chavez Saucedo on 5/4/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
class SVGCache {
    let filename : String
    private let cache = NSCache<NSString, NSString>()
    
    let dataContainer = DataContainer.cache
    
    init(filename : String) {
        self.filename = filename
    }
    
    func load() -> String? {
        if let svg = cache.object(forKey: filename as NSString){
            return String(svg)
        }
        guard let data = dataContainer.load(filename : filename) else {
            return nil
        }
        return String(decoding: data, as: UTF8.self)
    }
    
    func save(svg : String) -> Bool {
        DispatchQueue.global(qos: .background).async  {
            self.cache.setObject(NSString(string: svg), forKey: self.filename as NSString)
        }
        return dataContainer.save(data: Data(svg.utf8), filename: filename)
    }
}

//
//  ItemStorage.swift
//  fakestagram
//
//  Created by LuisE on 3/25/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

class ItemStorage<T> where T: Codable {
    public var item: T?
    private let store: CodableStorage<T>
    
    init(filename: String) {
        StorageType.permanent.ensureExists()
        store = CodableStorage<T>(filename: filename)
        item = store.load()
    }
    
    func save() -> Bool {
        guard let payload = item else { return false }
        return store.save(data: payload)
    }
}

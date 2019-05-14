//
//  Secrets.swift
//  fakestagram
//
//  Created by LuisE on 3/17/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
import SAMKeychain

enum Secrets {
    static let account = "com.3zcurdia.fakeinstagram"
    
    case host
    case uuid
    case token
    
    var value: String? {
        switch self {
        case .host:
            //return "http://192.168.46.71:3000/"
            return "https://fakestagram-api.herokuapp.com/"
        case .uuid:
            return nil
        case .token:
            return SAMKeychain.password(forService: "authentication", account: Secrets.account)
        }
    }
    
    func set(value : String) -> Bool {
        switch self {
        case .token:
                SAMKeychain.setPassword(value, forService: "authentication", account: Secrets.account)
                return true
        default:
                return false
        }
    }
    
}

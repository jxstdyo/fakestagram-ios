//
//  TimeLineClient.swift
//  fakestagram
//
//  Created by Antonyo Chavez Saucedo on 5/4/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
class TimeLineClient : RestClient<[Post]>{
    convenience init() {
        self.init(client : Client(), path : "/api/posts")
    }
    
    func show(page : Int, success : @escaping codableResponse  ){
        let items = ["page" : "\(page)"]
        request("GET", path: "\(path)", queryItems : items, payload: nil, success: success, errorHandler: nil)
    }
    
}


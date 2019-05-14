//
//  ProfileClient.swift
//  fakestagram
//
//  Created by Antonyo Chavez Saucedo on 5/4/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

class ProfileClient : RestClient<Author>{
    convenience init(){
        self.init(client : Client(), path : "/api/profile")
    }
}

class ProfilePostsClient : RestClient<[Post]>{
    convenience init(){
        self.init(client : Client(), path : "/api/profile/posts")
    }
}

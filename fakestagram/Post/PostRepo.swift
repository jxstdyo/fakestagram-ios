//
//  PostRepo.swift
//  fakestagram
//
//  Created by Antonyo Chavez Saucedo on 4/13/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
class PostRepo{
    static let shared = PostRepo()
    let restClient = RestClient<[Post]>(client: Client(), path: "/api/posts")
    typealias postResponse = ([Post]) -> Void
    func loadFeed(success: @escaping postResponse) {
        show() { posts in
            success(posts)
        }
    }
    
    func show(success: @escaping ([Post]) -> Void) {
        restClient.show(success: success)
    }
}

//
//  CommentClient.swift
//  fakestagram
//
//  Created by Antonyo Chavez Saucedo on 6/3/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
class CommentClient:  RestClient<[Comment]>{
    convenience init(postID : Int){
        self.init(client : Client(), path : "/api/posts/\(postID)/comments")
    }
}

class CommentCreateClient:  RestClient<Comment>{
    convenience init(postID : Int){
        self.init(client : Client(), path : "/api/posts/\(postID)/comments")
    }
    
    func create(payload : Comment, success : @escaping (Comment) -> Void ) {
        create(codable: payload, success: { _ in })
    }
}



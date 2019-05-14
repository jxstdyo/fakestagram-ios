//
//  LikeClient.swift
//  fakestagram
//
//  Created by Antonyo Chavez Saucedo on 4/26/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

class LikeUpdaterClient{
    
    private let client = Client()
    private let baseUrl = "/api/posts/"
    private var post : Post
    
    init(post : Post) {
        self.post = post
    }
    
    func call() -> Post{
        if !post.liked{
            return like()
        } else {
            return dislike()
        }
    }
    
    func like() -> Post {
        guard let postId = post.id else { return post }
        client.request("POST", path: "\(baseUrl)/\(postId)/like", body: nil, completionHandler: onSuccessLike(response:data:), errorHandler: onError(error:))
        var post = self.post
        post.likesCount += 1
        post.liked = true
        return post
    }
    
    func dislike()  -> Post {
        guard let postId = post.id else { return post }
        client.request("DELETE", path: "\(baseUrl)/\(postId)/like", body: nil, completionHandler: onSuccessDislike(response:data:), errorHandler: onError(error:))
        var post = self.post
        post.likesCount -= 1
        post.liked = false
        return post
    }
    
    private func onSuccessLike(response: HTTPResponse, data: Data?) -> Void{
        guard response.successful() else { return }
        post.likesCount += 1
        post.liked = true
        sendNotification(for : self.post)
    }
    
   func onSuccessDislike(response: HTTPResponse, data: Data?) {
        guard response.successful() else { return }
        var post = self.post
        post.likesCount -= 1
        post.liked = false
        sendNotification(for: post)
    }
    
    func sendNotification(for updatedPost: Post) {
        guard let data = try? JSONEncoder().encode(updatedPost) else { return }
        NotificationCenter.default.post(name: .didLikePost, object: nil, userInfo: ["post": data as Any] )
        
    }
    
    private func onError(error : Error?) -> Void {
        guard let err = error else {
            return
        }
        print("Error on post creation \(err.localizedDescription)")
    }
    
}

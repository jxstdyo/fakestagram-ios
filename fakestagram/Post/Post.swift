//
//  Post.swift
//  fakestagram
//
//  Created by LuisE on 3/16/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
import UIKit

struct Post: Codable {
    
    let id: Int?
    let title: String
    let imageUrl: String?
    let author: Author?
    var likesCount: Int
    let commentsCount: Int
    let createdAt: String
    let updatedAt: String
    
    var location : String
    var liked: Bool
    var row: Int?
    
    func load(_ image : @escaping (UIImage) -> Void){
        let cache = ImageCache(filename: "image-\(String(describing: self.id))")
        if let img = cache.load() {
            image(img)
            return
        }
        
        guard let urlString = imageUrl, let url = URL(string : urlString) else {
            return
        }
        DispatchQueue.global(qos: .background).async  {
            if let data = try? Data(contentsOf: url), let img = UIImage(data: data){
                DispatchQueue.main.async {
                    image(img)
                }
                _ = cache.save(image: img)
            }
        }
    }
    
    mutating func swapLike() -> Bool {
        self.liked = !self.liked
        return self.liked
    }
    
    
}

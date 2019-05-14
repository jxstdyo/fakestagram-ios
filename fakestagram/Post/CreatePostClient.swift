//
//  CreatePostClient.swift
//  fakestagram
//
//  Created by Antonyo Chavez Saucedo on 4/27/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation


struct CreatePostBase64 : Codable{
    let title : String
    let imageData : String
}

class CreatePostClient{
    private let client = Client()
    private let path = "/api/posts"
    
    private let encoder : JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    private let decoder : JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    init() {
        
    }
    
    func create(payload : CreatePostBase64, success : @escaping (Post) -> Void ) {
        guard let data = try? encoder.encode(payload) else {
            return
        }
        client.request("POST", path: path, body: data, completionHandler:{ (response, data) in
                if response.successful() {
                    guard let data = data else {
                        print("Error Empty Response")
                        return
                    }
                    do {
                        let json = try self.decoder.decode(Post.self, from: data)
                        success(json)
                    } catch {
                        print("Error on json deserialization")
                    }
                } else {
                    print("Error on post creation response: \(response.rawResponse) \(response.status) Body:\(String(describing: data))")
                }
            
        }, errorHandler: onError(error:))
    }
    
    private func onError(error : Error?) -> Void {
        guard let err = error else {
            return
        }
        print("Error on post creation \(err.localizedDescription)")
    }
}

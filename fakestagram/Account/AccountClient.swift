//
//  AccountClient.swift
//  fakestagram
//
//  Created by Antonyo Chavez Saucedo on 4/26/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

class AccountClient: RestClient<Like> {
    convenience init(postId : Int){
        self.init(client : Client(), path: "/posts/\(postId)/like" )
    }
}

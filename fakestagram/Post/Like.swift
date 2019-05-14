//
//  Like.swift
//  fakestagram
//
//  Created by Antonyo Chavez Saucedo on 4/26/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation
struct Like : Codable {
    let id : Int?
    let postId : Int?
    let accountId : String?
    let createAt : String?
    let updateAt : String?
}

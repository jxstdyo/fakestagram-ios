//
//  Comment.swift
//  fakestagram
//
//  Created by Antonyo Chavez Saucedo on 6/3/19.
//  Copyright © 2019 3zcurdia. All rights reserved.
//

import Foundation

struct Comment: Codable {
    let id: Int?
    let content: String
    let author: Author?
    let createdAt : String?
    let updatedAt : String?
}

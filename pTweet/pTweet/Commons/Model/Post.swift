//
//  Post.swift
//  pTweet
//
//  Created by Eddy Wister on 23/02/21.
//

import Foundation
struct Post: Codable {
    let id: String
    let author: User
    let imageUrl: String
    let text: String
    let videoUrl: String
    let location: PostLocation
    let hasVideo: Bool
    let hasImage: Bool
    let hasLocation: Bool
    let createdAt: String
}

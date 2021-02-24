//
//  PostRequest.swift
//  pTweet
//
//  Created by Eddy Wister on 23/02/21.
//

import Foundation

struct PostRequest: Codable {
    let text: String
    let imageUrl: String?
    let videoUrl: String?
    let location: PostRequestLocation?
}

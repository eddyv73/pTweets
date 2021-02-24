//
//  LoginResponse.swift
//  pTweet
//
//  Created by Eddy Wister on 23/02/21.
//

import Foundation

struct LoginResponse: Codable {
    let user: User
    let token: String
}

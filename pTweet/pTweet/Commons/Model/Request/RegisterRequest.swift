//
//  RegisterRequest.swift
//  pTweet
//
//  Created by Eddy Wister on 23/02/21.
//

import Foundation
struct RegisterRequest: Codable {
    let email: String
    let password: String
    let names: String
}

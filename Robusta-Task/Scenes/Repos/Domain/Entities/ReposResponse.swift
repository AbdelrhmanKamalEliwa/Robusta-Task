//
//  ReposResponse.swift
//  Repositories
//
//  Created by Abdelrhman Eliwa on 09/11/2022.
//

import Foundation

struct ReposResponse: Decodable, Identifiable {
    let id: Int?
    let name: String?
    let fullName: String?
    let isPrivate: Bool?
    let owner: Owner?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case isPrivate = "private"
        case owner
    }
}

struct Owner: Decodable {
    let id: Int?
    let avatarURL: String?

    enum CodingKeys: String, CodingKey {
        case id
        case avatarURL = "avatar_url"
    }
}

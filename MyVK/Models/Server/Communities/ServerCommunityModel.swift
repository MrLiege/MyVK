//
//  ServerGroupModel.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 22.09.2024.
//

import Foundation

struct ServerCommunityModel: Decodable {
    let id: Int?
    let name: String?
    let screenName: String?
    let activity: String?
    let membersCount: Int?
    let isClosed: Int?
    let deactivated: String?
    let type: String?
    let photoSmall: String?
    let photo: String?
    let photoBig: String?
    let ageLimits: Int?
    let description: String?
    let cover: ServerCover?
    let status: String?
    let site: String?
    let addresses: ServerAddresses?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case screenName = "screen_name"
        case activity
        case membersCount = "members_count"
        case isClosed = "is_closed"
        case deactivated
        case type
        case photoSmall = "photo_50"
        case photo = "photo_100"
        case photoBig = "photo_200"
        case ageLimits = "age_limits"
        case description
        case cover
        case status
        case site
        case addresses
    }
}

// MARK: - Cover
struct ServerCover: Decodable {
    let enabled: Int?
    let images: [ServerCoverImage]?
}


struct ServerCoverImage: Decodable {
    let url: String?
    let width: Int?
}

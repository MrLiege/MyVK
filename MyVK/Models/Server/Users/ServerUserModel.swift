//
//  ServerFriend.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 12.09.2024.
//

import Foundation

struct ServerUserModel: Decodable {
    let id: Int?
    let firstName: String?
    let lastName: String?
    let birthDate: String?
    let city: ServerUserCityModel?
    let lastSeen: ServerUserLastSeenModel?
    let photo: String?
    let photoSmall: String?
    let photoBig: String?
    let online: Int?
    let onlineMobile: Int?
    let sex: Int?
    let domain: String?
    let followersCount: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case birthDate = "bdate"
        case city
        case lastSeen = "last_seen"
        case photo = "photo_100"
        case photoSmall = "photo_50"
        case photoBig = "photo_200"
        case online
        case onlineMobile = "online_mobile"
        case sex
        case domain
        case followersCount = "followers_count"
    }
}

struct ServerUserCityModel: Decodable {
    let id: Int?
    let title: String?
}

struct ServerUserLastSeenModel: Decodable {
    let time: Int
}


//
//  Friend.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 12.09.2024.
//

import Foundation

struct User: Identifiable, Equatable {
    let id: Int
    let firstName: String
    let lastName: String
    let birthDate: String?
    let city: String?
    let lastSeen: Date?
    let photo: URL?
    let photoSmall: URL?
    let photoBig: URL?
    private let online: Bool?
    let onlineMobile: Bool?
    let gender: Gender?
    let domain: String?
    let followersCount: Int?
}

extension User {
    var visibleName: String {
        firstName + " " + lastName
    }
    
    var isOnline: Bool {
        guard let online else { return false }
        
        if let onlineMobile, onlineMobile {
            return true
        }
        
        return online
    }
}

extension User {
    init(from serverModel: ServerUserModel) {
        id = serverModel.id ?? UUID().hashValue
        firstName = serverModel.firstName.orEmpty
        lastName = serverModel.lastName.orEmpty
        birthDate = serverModel.birthDate
        city = serverModel.city?.title
        lastSeen = Date.getDateFromUnix(time: serverModel.lastSeen?.time)
        photo = URL(string: serverModel.photo.orEmpty)
        photoSmall = URL(string: serverModel.photoSmall.orEmpty)
        photoBig = URL(string: serverModel.photoBig.orEmpty)
        online = Bool.getBoolFrom(value: serverModel.online)
        onlineMobile = Bool.getBoolFrom(value: serverModel.onlineMobile)
        gender = .init(rawValue: serverModel.sex.orZero)
        domain = serverModel.domain
        followersCount = serverModel.followersCount
    }
}

extension User {
    static var empty: Self {
        .init(
            id: 0,
            firstName: "",
            lastName: "",
            birthDate: nil,
            city: nil,
            lastSeen: nil,
            photo: nil,
            photoSmall: nil,
            photoBig: nil,
            online: nil,
            onlineMobile: nil,
            gender: nil,
            domain: nil,
            followersCount: nil
        )
    }
}

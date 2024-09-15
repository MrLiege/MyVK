//
//  Friend.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 12.09.2024.
//

import Foundation

struct Friend: Identifiable, Equatable {
    let id: Int
    let firstName: String
    let lastName: String
    let birthDate: String?
    let city: String?
    let lastSeen: Date?
    let photo: URL?
    private let online: Bool?
    let onlineMobile: Bool?
    let gender: Gender?
}

extension Friend {
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

extension Friend {
    init(from serverModel: ServerFriendModel) {
        id = serverModel.id ?? UUID().hashValue
        firstName = serverModel.firstName.orEmpty
        lastName = serverModel.lastName.orEmpty
        birthDate = serverModel.birthDate
        city = serverModel.city?.title
        lastSeen = Date.getDateFromUnix(time: serverModel.lastSeen?.time)
        photo = URL(string: serverModel.photo.orEmpty)
        online = Bool.getBoolFrom(value: serverModel.online)
        onlineMobile = Bool.getBoolFrom(value: serverModel.onlineMobile)
        gender = .init(rawValue: serverModel.sex.orZero)
    }
}

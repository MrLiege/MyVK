//
//  Group.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 22.09.2024.
//

import Foundation

struct Community: Identifiable, Equatable {
    let id: Int?
    let name: String?
    let screenName: String?
    let membersCount: Int?
    let activity: String?
    let isClosed: Int?
    let deactivated: String?
    let type: String?
    let photoSmall: URL?
    let photo: URL?
    let photoBig: URL?
    let ageLimits: Int?
    let description: String?
    let cover: Cover?
    let status: String?
    let site: String?
    let addresses: Addresses?
    
    func getPhotoURL(by type: PhotoType) -> URL? {
        switch type {
        case .photoSmall:
            return photoSmall
        case .photo:
            return photo
        case .photoBig:
            return photoBig
        }
    }
}

enum PhotoType {
    case photoSmall
    case photo
    case photoBig
}

extension Community {
    init(from serverModel: ServerCommunityModel) {
        self.id = serverModel.id ?? UUID().hashValue
        self.name = serverModel.name.orEmpty
        self.screenName = serverModel.screenName.orEmpty
        self.membersCount = serverModel.membersCount
        self.activity = serverModel.activity.orEmpty
        self.isClosed = serverModel.isClosed
        self.deactivated = serverModel.deactivated.orEmpty
        self.type = serverModel.type.orEmpty
        self.photoSmall = URL(string: serverModel.photoSmall.orEmpty)
        self.photo = URL(string: serverModel.photo.orEmpty)
        self.photoBig = URL(string: serverModel.photoBig.orEmpty)
        self.ageLimits = serverModel.ageLimits
        self.description = serverModel.description.orEmpty
        self.cover = serverModel.cover.map { Cover(from: $0) }
        self.status = serverModel.status.orEmpty
        self.site = serverModel.site.orEmpty
        self.addresses = serverModel.addresses.map { Addresses(from: $0) }
    }
}

extension Community {
    static var empty: Self {
        .init(
            id: 0,
            name: "",
            screenName: "",
            membersCount: 0,
            activity: "",
            isClosed: 0,
            deactivated: "",
            type: "",
            photoSmall: nil,
            photo: nil,
            photoBig: nil,
            ageLimits: 0,
            description: "",
            cover: nil,
            status: "",
            site: "",
            addresses: nil
        )
    }
}

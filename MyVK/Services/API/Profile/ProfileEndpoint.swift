//
//  ProfileEndpoint.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 17.09.2024.
//

import AsyncNetwork

enum ProfileEndpoint: RequestEndpoint {
    case getMyProfile
    case getPhotos(AlbumIdentifier?)
    
    var host: String {
        Consts.Base.hostURL
    }
    
    var path: String {
        switch self {
        case .getMyProfile:
            "/method/users.get"
        case .getPhotos:
            "/method/photos.get"
        }
    }
    
    var method: RequestMethod {
        .get
    }
    
    var query: RequestQuery? {
        var params: [String : String] = [:]
        switch self {
        case .getMyProfile:
            params["fields"] = "bdate,domain,followers_count,photo_50,photo_200,sex,last_seen,online"
        case .getPhotos(let identifier):
            params["album_id"] = (identifier ?? .profile).queryParam
        }
        params["access_token"] = UserStorage.shared.token.orEmpty
        params["v"] = "5.199"
        return params
    }
}

enum AlbumIdentifier {
    case id(Int)
    case wall
    case saved
    case profile
    
    var queryParam: String {
        switch self {
        case .id(let id):
            return String(id)
        case .wall:
            return "wall"
        case .saved:
            return "saved"
        case .profile:
            return "profile"
        }
    }
}

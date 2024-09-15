//
//  FriendsEndpoint.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 13.09.2024.
//

import AsyncNetwork

enum FriendsEndpoint: RequestEndpoint {
    case getList(offset: Int, count: Int)
    
    var host: String {
        Consts.Base.hostURL
    }
    
    var path: String {
        "/method/friends.get"
    }
    
    var method: RequestMethod {
        .get
    }
    
    var query: RequestQuery? {
        if case let .getList(offset, count) = self {
            var params: [String : String] = [:]
            params["access_token"] = UserStorage.shared.token.orEmpty
            params["fields"] = "bdate,city,country,last_seen,online,photo_100,sex"
            params["offset"] = String(offset)
            params["count"] = String(count)
            params["v"] = "5.199"
            return params
        } else {
            return nil
        }
    }
}

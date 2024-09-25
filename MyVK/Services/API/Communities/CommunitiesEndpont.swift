//
//  GroupsEndpont.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 22.09.2024.
//

import AsyncNetwork

enum CommunitiesEndpont: RequestEndpoint {
    case getList(offset: Int, count: Int)
    case getCommunity(commun: String)
    
    var host: String {
        Consts.Base.hostURL
    }
    
    var path: String {
        switch self {
        case .getList:
            "/method/groups.get"
        case .getCommunity:
            "/method/groups.getById"
        }
    }
    
    var method: RequestMethod {
        .get
    }
    
    var query: RequestQuery? {
        var params: [String : String] = [:]
        switch self {
        case let .getList(offset, count):
            params["access_token"] = UserStorage.shared.token.orEmpty
            params["extended"] = "1"
            params["offset"] = String(offset)
            params["count"] = String(count)
            params["fields"] = "id,members_count,activity,name,screen_name,photo_200"
        case let .getCommunity(commun):
            params["access_token"] = UserStorage.shared.token.orEmpty
            params["group_id"] = String(commun)
            params["fields"] = "id,members_count,activity,name,screen_name,photo_50,photo_100,photo_200,cover,description,status,contacts,site,addresses"
        }
        params["v"] = "5.199"
        return params
    }
}

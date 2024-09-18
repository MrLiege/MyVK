//
//  FriendsAPIClient.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 13.09.2024.
//

import AsyncNetwork
import ComposableArchitecture

struct FriendsAPIClient {
    @Dependency(\.networkClient) private static var networkClient
    
    var getList: (_ offset: Int, _ count: Int) async throws -> (users: [User], count: Int)
}

extension FriendsAPIClient: DependencyKey {
    static var liveValue = FriendsAPIClient { offset, count in
        let endpoint = FriendsEndpoint.getList(offset: offset, count: count)
        
        let data = try await networkClient.sendRequest(with: endpoint)
            .decode(
                to: ArrayInnerResponseModel<ServerUserModel>.self,
                at: "response"
            )
            
        return ((data.items ?? []).compactMap { User(from: $0) }, data.count.orZero)
    }
}

extension DependencyValues {
    var friendsClient: FriendsAPIClient {
        get { self[FriendsAPIClient.self] }
        set { self[FriendsAPIClient.self] = newValue }
    }
}

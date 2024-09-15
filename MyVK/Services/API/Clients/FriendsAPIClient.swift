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
    
    var getList: (_ offset: Int, _ count: Int) async throws -> [Friend]
}

extension FriendsAPIClient: DependencyKey {
    static var liveValue = FriendsAPIClient { offset, count in
        let endpoint = FriendsEndpoint.getList(offset: offset, count: count)
        
        let data = try await networkClient.sendRequest(with: endpoint)
            .decode(
                to: ArrayInnerResponseModel<ServerFriendModel>.self,
                at: "response"
            )
            .items
            
        return (data ?? []).compactMap { Friend(from: $0) }
    }
}

extension DependencyValues {
    var friendsClient: FriendsAPIClient {
        get { self[FriendsAPIClient.self] }
        set { self[FriendsAPIClient.self] = newValue }
    }
}

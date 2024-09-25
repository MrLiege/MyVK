//
//  GroupsAPIClient.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 22.09.2024.
//

import AsyncNetwork
import ComposableArchitecture

struct CommunitiesAPIClient {
    @Dependency(\.networkClient) private static var networkClient
    
    var getList: (_ offset: Int, _ count: Int) async throws -> (communs: [Community], count: Int)
    var getCommunity: (_ commun: String?) async throws -> Community
}

extension CommunitiesAPIClient: DependencyKey {
    static var liveValue = CommunitiesAPIClient(
        getList: { offset, count in
            let endpoint = CommunitiesEndpont.getList(offset: offset, count: count)
            
            let data = try await networkClient.sendRequest(with: endpoint)
                .decode(
                    to: ArrayInnerResponseModel<ServerCommunityModel>.self,
                    at: "response"
                )
            
            return ((data.items ?? []).compactMap { Community(from: $0) }, data.count.orZero)
        },
        
        getCommunity: { groupId in
            guard let groupId = groupId else {
                throw CustomError.invalidGroupId
            }
            
            let endpoint = CommunitiesEndpont.getCommunity(commun: groupId)
            
            let data = try await networkClient.sendRequest(with: endpoint)
                .decode(
                    to: SingleResponseModel<ServerCommunityModel>.self,
                    at: "response"
                )
            
            guard let response = data.groups?.first else {
                throw CustomError.invalidResponse
            }
            return Community(from: response)
        }
    )
}

private extension CommunitiesAPIClient {
    static func sendRequest<T: Decodable>(
        with endpoint: CommunitiesEndpont,
        _ responseType: T.Type
    ) async throws -> T {
        try await networkClient.sendRequest(with: endpoint)
            .decode(
                to: responseType,
                at: "response"
            )
    }
}

extension DependencyValues {
    var communitiesClient: CommunitiesAPIClient {
        get { self[CommunitiesAPIClient.self] }
        set { self[CommunitiesAPIClient.self] = newValue }
    }
}

enum CustomError: Error {
    case invalidGroupId
    case invalidResponse
    case decodeError
}

//
//  ProfileAPIClient.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 17.09.2024.
//

import AsyncNetwork
import ComposableArchitecture

struct ProfileAPIClient {
    @Dependency(\.networkClient) private static var networkClient
    
    var getProfile: () async throws -> User
    var getPhotos: (_ album: AlbumIdentifier?) async throws -> [UserPhoto]
}

extension ProfileAPIClient: DependencyKey {
    static var liveValue = ProfileAPIClient(
        getProfile: {
            let data = try await sendRequest(with: .getMyProfile, [ServerUserModel].self)
            
            guard let profile = data.first else { throw NetworkError.decode(nil) }
            
            return .init(from: profile)
        },
        getPhotos: { identifier in
            let data = try await sendRequest(
                with: .getPhotos(identifier), ArrayInnerResponseModel<ServerPhotoModel>.self
            ).items ?? []
            
            return data.compactMap { UserPhoto(from: $0) }
        }
    )
}

private extension ProfileAPIClient {
    static func sendRequest<T: Decodable>(
        with endpoint: ProfileEndpoint,
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
    var profileClient: ProfileAPIClient {
        get { self[ProfileAPIClient.self] }
        set { self[ProfileAPIClient.self] = newValue }
    }
}

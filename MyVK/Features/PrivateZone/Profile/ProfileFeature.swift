//
//  ProfileFeature.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 17.09.2024.
//

import ComposableArchitecture

@Reducer
struct ProfileFeature {
    @ObservableState
    struct State {
        var loadableView = LoadableViewFeature.State()
        
        // MARK: Profile
        var isProfileLoading = false
        var profile: User = .empty
        
        // MARK: Friends
        var isFriendsLoading = false
        var friends: [User] = []
        var friendsCommonCount: Int = 0
        
        // MARK: Photo
        var isPhotoLoading = false
        var photos: [UserPhoto] = []
        var photoSizes: [UserPhotoSize] {
            photos.flatMap(\.sizes).filter { $0.type == "m" }
        }
    }
    
    enum Action: BindableAction {
        case onAppear
        case loadableView(LoadableViewFeature.Action)
        case binding(BindingAction<State>)
        
        // MARK: Requests
        case profileRequest
        case profileResponse(Result<User, Error>)
        case friendsRequest
        case friendsResponse(Result<(users: [User], count: Int), Error>)
        case photoRequest
        case photoResponse(Result<[UserPhoto], Error>)
    }
    
    @Dependency(\.profileClient) private var profileClient
    @Dependency(\.friendsClient) private var friendsClient
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Scope(state: \.loadableView, action: \.loadableView) {
            LoadableViewFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .merge(
                    .send(.profileRequest),
                    .send(.friendsRequest),
                    .send(.photoRequest)
                )
                // MARK: - Profile
            case .profileRequest:
                state.isProfileLoading = true
                return .run { send in
                    await send(
                        .profileResponse(
                            Result {
                                try await profileClient.getProfile()
                            }
                        )
                    )
                }
            case let .profileResponse(.success(model)):
                state.profile = model
                state.isProfileLoading = false
                return .none
                // MARK: - Friends
            case .friendsRequest:
                state.isFriendsLoading = true
                return .run { send in
                    await send(
                        .friendsResponse(
                            Result {
                                try await Task.sleep(for: .seconds(1))
                                return try await friendsClient.getList(
                                    Constants.friendsOffset,
                                    Constants.friendsLimit
                                )
                            }
                        )
                    )
                }
            case let .friendsResponse(.success(model)):
                state.friends = model.users
                state.friendsCommonCount = model.count
                state.isFriendsLoading = false
                return .none
            case let .friendsResponse(.failure(error)),
                let .profileResponse(.failure(error)),
                let .photoResponse(.failure(error)):
                state.loadableView.isErrorShowing = true
                print(error)
                return .none
                // MARK: - Photos
            case .photoRequest:
                state.isPhotoLoading = true
                return .run { send in
                    await send(
                        .photoResponse(
                            Result {
                                try await profileClient.getPhotos(nil)
                            }
                        )
                    )
                }
            case let .photoResponse(.success(models)):
                state.photos = models
                state.isPhotoLoading = false
                return .none
            case .loadableView, .binding:
                return .none
            }
        }
    }
}

private enum Constants {
    static let friendsOffset = 0
    static let friendsLimit = 10
}

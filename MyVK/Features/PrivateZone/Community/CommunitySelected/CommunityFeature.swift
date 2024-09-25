//
//  CommunityFeature.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 24.09.2024.
//

import ComposableArchitecture

@Reducer
struct CommunityFeature {
    @ObservableState
    struct State: Equatable {
        var loadableView = LoadableViewFeature.State(screenState: .loaded)
        var errorMessage: String? = nil
        
        // MARK: Community
        var isCommunityLoading = false
        var community: Community = .empty
    }
    
    enum Action: BindableAction {
        case onAppear
        case loadableView(LoadableViewFeature.Action)
        case binding(BindingAction<State>)
        
        // MARK: - Requests
        case getCommunity
        case getCommunityResponse(Result<Community, Error>)
    }
    
    @Dependency(\.communitiesClient) private var communitiesClient
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Scope(state: \.loadableView, action: \.loadableView) {
            LoadableViewFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                if !state.isCommunityLoading {
                    return .send(.getCommunity)
                }
                return .none
            case .getCommunity:
                state.isCommunityLoading = true
                let communityId = state.community.id
                return .run { send in
                    await send(
                        .getCommunityResponse(
                            Result {
                                try await communitiesClient.getCommunity(String(communityId ?? 0))
                            }
                        )
                    )
                }
            case let .getCommunityResponse(.success(model)):
                state.community = model
                state.isCommunityLoading = false
                return .none
            case let .getCommunityResponse(.failure(error)):
                state.loadableView.errorMessage = error.localizedDescription
                state.loadableView.isErrorShowing = true
                state.isCommunityLoading = false
                return .none
            case .binding, .loadableView:
                return .none
            }
        }
    }
}

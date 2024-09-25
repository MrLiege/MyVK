//
//  CommunityFeature.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 22.09.2024.
//

import ComposableArchitecture

@Reducer
struct CommunitiesFeature {
    @ObservableState
    struct State: Equatable {
        var communities: [Community] = []
        var loadableView = LoadableViewFeature.State(screenState: .loaded)
        var path = StackState<Path.State>()
        var errorMessage: String? = nil
        
        // MARK: - Pagination
        var paginationOffset = 0
        var isPaginationLoading = false
        var hasMoreCommunities = true
    }
    
    enum Action: BindableAction {
        case onAppear
        case onRefresh
        case onPaginationLoad
        case loadableView(LoadableViewFeature.Action)
        case path(StackAction<Path.State, Path.Action>)
        case binding(BindingAction<State>)
        
        // MARK: Transitions
        case showCommunity(Community)
        
        // MARK: - Requests
        case getCommunities
        case getCommunitiesResponse(Result<[Community], Error>)
    }
    
    @Dependency(\.communitiesClient) private var communitiesClient
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Scope(state: \.loadableView, action: \.loadableView) {
            LoadableViewFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .onAppear, .onPaginationLoad:
                if state.hasMoreCommunities && !state.isPaginationLoading {
                    return .send(.getCommunities)
                }
                return .none
            case .onRefresh:
                state.communities = []
                state.paginationOffset = 0
                return .send(.getCommunities)
            case .getCommunities:
                if state.communities.isEmpty {
                    state.loadableView.screenState = .loading
                } else {
                    state.isPaginationLoading = true
                }
                
                return .run { [state] send in
                    await send(.getCommunitiesResponse(
                        Result {
                            try await communitiesClient.getList(
                                state.paginationOffset,
                                Constants.paginationCount
                            )
                            .communs
                        }
                    ))
                }
            case let .getCommunitiesResponse(.success(result)):
                if state.isPaginationLoading {
                    state.communities += result
                    state.isPaginationLoading = false
                } else {
                    state.communities = result
                    state.loadableView.screenState = .loaded
                }
                
                state.paginationOffset += Constants.paginationCount
                state.hasMoreCommunities = result.count == Constants.paginationCount
                return .none
            case let .getCommunitiesResponse(.failure(error)):
                print(error)
                state.loadableView.isErrorShowing = true
                state.isPaginationLoading = false
                return .none
            case let .showCommunity(community):
                state.path.append(.community(CommunityFeature.State(community: community)))
                return .none
            case .binding, .loadableView, .path:
                return .none
            }
        }
        .forEach(\.path, action: \.path)
    }
}

extension CommunitiesFeature {
    @Reducer(state: .equatable)
    enum Path {
        case community(CommunityFeature)
    }
}

private enum Constants {
    static let paginationCount = 30
}

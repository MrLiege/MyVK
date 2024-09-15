//
//  FriendsListFeature.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 13.09.2024.
//

import ComposableArchitecture

@Reducer
struct FriendsListFeature {
    @ObservableState
    struct State {
        var friends: [Friend] = []
        var loadableView = LoadableViewFeature.State(screenState: .loaded)
        var errorMessage: String? = nil
        
        // MARK: - Pagination
        var paginationOffset = 0
        var isPaginationLoading = false
    }
    
    
    enum Action: BindableAction {
        case onAppear
        case onRefresh
        case onPaginationLoad
        case loadableView(LoadableViewFeature.Action)
        case binding(BindingAction<State>)
        
        // MARK: - Requests
        case getFriends
        case getFriendsResponse(Result<[Friend], Error>)
    }
    
    @Dependency(\.friendsClient) private var friendsClient
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Scope(state: \.loadableView, action: \.loadableView) {
            LoadableViewFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .onAppear, .onPaginationLoad:
                return .send(.getFriends)
            case .onRefresh:
                state.friends = []
                state.paginationOffset = 0
                return .send(.getFriends)
            case .getFriends:
                if state.friends.isEmpty {
                    state.loadableView.screenState = .loading
                } else {
                    state.isPaginationLoading = true
                }
                
                return .run { [state] send in
                    await send(.getFriendsResponse(
                        Result {
                            try await friendsClient.getList(
                                state.paginationOffset,
                                Constants.paginationCount
                            )
                        }
                    ))
                }
            case let .getFriendsResponse(.success(result)):
                if state.isPaginationLoading {
                    state.friends += result
                    state.isPaginationLoading = false
                } else {
                    state.friends = result
                    state.loadableView.screenState = .loaded
                }
                state.paginationOffset += Constants.paginationCount
                return .none
            case let .getFriendsResponse(.failure(error)):
                state.loadableView.errorMessage = error.localizedDescription
                state.loadableView.isErrorShowing = true
                return .none
            case .binding, .loadableView:
                return .none
            }
        }
    }
}

private enum Constants {
    static let paginationCount = 30
}

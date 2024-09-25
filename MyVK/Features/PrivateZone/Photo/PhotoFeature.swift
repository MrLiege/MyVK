//
//  PhotoFeature.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 19.09.2024.
//

import ComposableArchitecture

@Reducer
struct PhotoFeature {
    @ObservableState
    struct State: Equatable {
        var loadableView = LoadableViewFeature.State()
        var photos: [UserPhotoSize] = []
    }
    
    enum Action: BindableAction {
        case onAppear
        case loadableView(LoadableViewFeature.Action)
        case binding(BindingAction<State>)
        
        case photoRequest
        case photoResponse(Result<[UserPhoto], Error>)
    }
    
    @Dependency(\.profileClient) private var profileClient
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Scope(state: \.loadableView, action: \.loadableView) {
            LoadableViewFeature()
        }
        
        Reduce { state, action in
            switch action {
            case .onAppear:
                state.loadableView.screenState = .loading
                return .send(.photoRequest)
            case .photoRequest:
                return .run { send in
                    await send(.photoResponse(Result {
                        try await profileClient.getPhotos(.profile)
                    }))
                }
            case let .photoResponse(.success(models)):
                state.photos = models.flatMap(\.sizes).filter { $0.type == "s" }
                state.loadableView.screenState = .loaded
                return .none
            case let .photoResponse(.failure(error)):
                state.loadableView.errorMessage = error.localizedDescription
                state.loadableView.isErrorShowing = true
                print(error)
                return .none
            case .loadableView, .binding:
                return .none
            }
        }
    }
}

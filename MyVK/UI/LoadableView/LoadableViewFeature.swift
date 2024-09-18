//
//  LoadableViewFeature.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 14.09.2024.
//

import ComposableArchitecture

enum LoadableScreenState {
    case loading
    case loaded
}

@Reducer
struct LoadableViewFeature {
    @ObservableState
    struct State: Equatable {
        var screenState: LoadableScreenState = .loaded
        var isErrorShowing = false
        var errorMessage: String? = nil
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        case onRepeat
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Reduce { state, action in
            switch action {
            case .onRepeat:
                state.isErrorShowing = false
                state.screenState = .loading
                state.errorMessage = nil
                return .none
            case .binding:
                return .none
            }
        }
    }
}

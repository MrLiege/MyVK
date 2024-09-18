//
//  TabBarFeature.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 09.09.2024.
//

import Foundation
import SwiftUI
import ComposableArchitecture

@Reducer
struct TabBarFeature {
    
    @ObservableState
    struct State {
        var currentTab: Tab = .friends
        
        var profile = ProfileFeature.State()
        var friends = FriendsListFeature.State()
    }
    
    enum Action: BindableAction {
        case profile(ProfileFeature.Action)
        case friends(FriendsListFeature.Action)
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Scope(state: \.profile, action: \.profile) {
            ProfileFeature()
        }
        
        Scope(state: \.friends, action: \.friends) {
            FriendsListFeature()
        }
        
//        Reduce { state, action in
//            switch action {
//            case .change(let tab):
//                    state.currentTab = tab
//                return .none
//            case .binding:
//                return .none
//            }
    }
}

extension TabBarFeature {
    enum Tab {
        case friends
        case profile
        
        var iconName: String {
            switch self {
            case .friends:
                return "person.2.fill"
            case .profile:
                return "person.crop.circle"
            }
        }
        
        var titleName: String {
            switch self {
            case .friends:
                return "Друзья"
            case .profile:
                return "Профиль"
            }
        }
    }
}

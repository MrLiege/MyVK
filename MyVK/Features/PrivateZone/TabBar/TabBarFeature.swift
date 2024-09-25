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
        var currentTab: Tab = .community
        
        var profile = ProfileFeature.State()
        var community = CommunitiesFeature.State()
        var friends = FriendsListFeature.State()
    }
    
    enum Action: BindableAction {
        case profile(ProfileFeature.Action)
        case community(CommunitiesFeature.Action)
        case friends(FriendsListFeature.Action)
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
        
        Scope(state: \.profile, action: \.profile) {
            ProfileFeature()
        }
        
        Scope(state: \.community, action: \.community) {
            CommunitiesFeature()
        }
        
        Scope(state: \.friends, action: \.friends) {
            FriendsListFeature()
        }
    }
}

extension TabBarFeature {
    enum Tab {
        case friends
        case community
        case profile
        
        var iconName: String {
            switch self {
            case .friends:
                return "person.2.fill"
            case .community:
                return "person.3.fill"
            case .profile:
                return "person.crop.circle"
            }
        }
        
        var titleName: String {
            switch self {
            case .friends:
                return "Друзья"
            case .community:
                return "Группы"
            case .profile:
                return "Профиль"
            }
        }
    }
}

//
//  TabBarView.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 09.09.2024.
//

import SwiftUI
import ComposableArchitecture

struct TabBarView: View {
    
    @Bindable var store: StoreOf<TabBarFeature>
    
    var body: some View {
        TabView(selection: $store.currentTab) {
            friendTabView
            profileTabView
        }
        .tint(Color.mint)
    }
}


// MARK: - Main Buttons on TabBar
private extension TabBarView {
    @ViewBuilder
    var friendTabView: some View {
        let tab = TabBarFeature.Tab.friends
        FriendsListView(store: Store(
            initialState: FriendsListFeature.State(),
            reducer: {
                FriendsListFeature()
            })
        )
        .tabItem {
            Image(systemName: tab.iconName)
            Text(tab.titleName)
        }
        .tag(tab)
    }
    
    @ViewBuilder
    var profileTabView: some View {
        let tab = TabBarFeature.Tab.profile
        Color.gray.ignoresSafeArea()
            .tabItem {
                Image(systemName: tab.iconName)
                Text(tab.titleName)
            }
            .tag(tab)
    }
}


#Preview {
    TabBarView(
        store: Store(
            initialState: TabBarFeature.State(),
            reducer: {
                TabBarFeature()
            }
        )
    )
}

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
        .safeAreaInset(edge: .top) {
            switchTabButton(tab: store.currentTab == .friends ? .profile : .friends)
        }
    }
}


// MARK: - Main Buttons on TabBar
private extension TabBarView {
    @ViewBuilder
    var friendTabView: some View {
        let tab = TabBarFeature.Tab.friends
        Color.brown.ignoresSafeArea()
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


// MARK: - Buttons for switching tab
private extension TabBarView {
    @ViewBuilder
    func switchTabButton(tab: TabBarFeature.Tab) -> some View {
        Button(action: { store.send(.change(tab: tab))}) {
            Text("\(tab.titleName)")
        }
        .padding()
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

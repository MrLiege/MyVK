//
//  FriendsListView.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 13.09.2024.
//

import SwiftUI
import ComposableArchitecture

struct FriendsListView: View {
    
    @Bindable var store: StoreOf<FriendsListFeature>
    
    var body: some View {
        NavigationStack(path: .constant(.init())) {
            LoadableView(
                store: store.scope(
                    state: \.loadableView,
                    action: \.loadableView)
            ) {
                ScrollView {
                    LazyVStack(spacing: 8) {
                        ForEach(store.friends) { model in
                            FriendsListItemView(model: model)
                        }
                        
                        paginationView
                    }
                    .padding()
                }
                .refreshable {
                    Task {
                        try await Task.sleep(for: .seconds(0.15))
                        refreshAction()
                    }
                }
            } skeleton: { skeletonView }
            .navigationTitle("Друзья")
            .onAppear(perform: appearAction)
        }
    }
}

private extension FriendsListView {
    @ViewBuilder
    var paginationView: some View {
        if store.isPaginationLoading {
            ProgressView()
        } else if store.loadableView.screenState != .loading {
            Color.clear
                .frame(height: 1)
                .onAppear(perform: paginationAction)
        }
    }
}

private extension FriendsListView {
    @ViewBuilder
    var skeletonView: some View {
        VStack(spacing: 8) {
            ForEach(0..<5) { _ in
                FriendsSceletonView()
            }
        }
        .padding()
    }
}

private extension FriendsListView {
    func appearAction() {
        store.send(.onAppear)
    }
    
    func refreshAction() {
        store.send(.onRefresh)
    }
    
    func paginationAction() {
        store.send(.onPaginationLoad)
    }
}

//#Preview {
//    FriendsListView()
//}

//
//  CommunityView.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 22.09.2024.
//

import SwiftUI
import ComposableArchitecture

struct CommunitiesView: View {
    
    @Bindable var store: StoreOf<CommunitiesFeature>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            LoadableView(
                store: store.scope(
                    state: \.loadableView,
                    action: \.loadableView)
            ) {
                mainContent
                .refreshable {
                    refreshAction()
                }
            } skeleton: { CommunitiesListSceletonView() }
                .navigationTitle("Сообщества")
                .onAppear(perform: appearAction)
        } destination: { store in
            switch store.case {
            case let .community(store):
                CommunityView(store: store)
            }
        }
    }
}

private extension CommunitiesView {
    @ViewBuilder
    var mainContent: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: Constants.gridItems, alignment: .center, spacing: 10) {
                ForEach(store.communities) { model in
                    CommunitiesListView(model: model)
                        .frame(
                            maxWidth: Constants.gridWidthSize,
                            maxHeight: Constants.gridHeightSize
                        )
                        .onTapGesture {
                            store.send(.showCommunity(model))
                        }
                }
                paginationView
            }
            .padding()
        }
    }
}

private extension CommunitiesView {
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

private extension CommunitiesView {
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

private enum Constants {
    static let gridWidthSize = (UIScreen.main.bounds.width - 90) / 2
    static let gridHeightSize = (UIScreen.main.bounds.height - 100) / 3
    static let gridItems: [GridItem] = Array(repeating: .init(.fixed(gridWidthSize)), count: 2)
}

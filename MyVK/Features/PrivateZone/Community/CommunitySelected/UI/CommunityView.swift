//
//  CommunityView.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 24.09.2024.
//

import SwiftUI
import ComposableArchitecture

struct CommunityView: View {
    
    @Bindable var store: StoreOf<CommunityFeature>
    
    var body: some View {
        LoadableView(store: store.scope(
            state: \.loadableView,
            action: \.loadableView)) {
                ScrollView {
                    VStack {
                        CommunityInfoView(model: store.community)
                            .padding(.top, Constants.paddingCommunInfoTop)
                        VStack {
                            CommunityDetailInfoView(model: store.community)
                            
                        }.padding(.top, Constants.paddingCommunDetailTop)
                            
                    }
                }
            } skeleton: { sceletonView }
            .navigationTitle("")
            .onAppear(perform: appearAction)
    }
}

private extension CommunityView {
    @ViewBuilder
    var sceletonView: some View {
        ScrollView {
            VStack {
                CommunityInfoSkeletonView()
                    .padding(.top, Constants.paddingCommunInfoTop)
                VStack {
                    CommunityDetailInfoSkeletonView()
                }
                .padding(.top, Constants.paddingCommunDetailTop)
            }
        }
    }
}

private extension CommunityView {
    func appearAction() {
        store.send(.onAppear)
    }
}

private enum Constants {
    static let paddingCommunInfoTop: Double = -165
    static let paddingCommunDetailTop: Double = 170
}

//
//  ProfileView.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 17.09.2024.
//

import SwiftUI
import ComposableArchitecture

struct ProfileView: View {
    
    @Bindable var store: StoreOf<ProfileFeature>
    
    var body: some View {
        NavigationStack(path: $store.scope(state: \.path, action: \.path)) {
            LoadableView(
                store: store.scope(
                    state: \.loadableView,
                    action: \.loadableView)
            ) {
                ScrollView(.vertical) {
                    VStack(spacing: 16) {
                        ProfileInfoView(model: store.profile)
                            .roundedContainer(isLoading: store.isProfileLoading)
                        ProfileFriendsListView(models: store.friends)
                            .roundedContainer(
                                "Друзья: \(store.friendsCommonCount)",
                                isLoading: store.isFriendsLoading
                            )
                        
                        ProfilePhotosListView(models: store.photoSizes)
                            .roundedContainer(
                                "Фото: \(store.photoSizes.count)",
                                isLoading: store.isPhotoLoading,
                                action: showPhotos
                            )
                    }
                }
            } skeleton: {
                ProfileSceletonView()
            }
            .navigationTitle("Профиль")
            .onAppear(perform: appearAction)
        } destination: { store in
            switch store.case {
            case let .photos(store):
                PhotoView(store: store)
            }
        }
    }
}

private extension ProfileView {
    func appearAction() {
        store.send(.onAppear)
    }
    
    func showPhotos() {
        store.send(.showPhotos)
    }
}

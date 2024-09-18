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
        NavigationStack {
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
                                isLoading: store.isPhotoLoading
                            )
                    }
                }
            } skeleton: {
                ProfileSceletonView()
            }
            .navigationTitle("Профиль")
            .onAppear(perform: appearAction)
        }
    }
}

private extension ProfileView {
    func appearAction() {
        store.send(.onAppear)
    }
}

private extension ProfileView {
    @ViewBuilder
    var skeletonView: some View {
        Text("")
    }
}

//#Preview {
//    ProfileView()
//}

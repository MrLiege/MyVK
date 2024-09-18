//
//  ProfileFriendsListView.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 17.09.2024.
//

import SwiftUI

struct ProfileFriendsListView: View {
    
    let models: [User]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 4) {
                ForEach(models) { model in
                    AsyncImage(url: model.photo)
                        .frame(width: Constants.imageSize, height: Constants.imageSize)
                        .aspectRatio(contentMode: .fit)
                        .clipShape(.rect(cornerRadius: .infinity))
                        .overlay(alignment: .bottomTrailing) {
                            if model.isOnline {
                                OnlineIndicatorView(isBig: false, borderColor: .white, fromPhone: model.onlineMobile ?? false)
                            }
                        }
                }
            }
        }
    }
}

private enum Constants {
    static let imageSize: Double = 54
}

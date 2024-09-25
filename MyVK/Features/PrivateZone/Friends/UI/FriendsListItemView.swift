//
//  FriendsListItemView.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 14.09.2024.
//

import SwiftUI

struct FriendsListItemView: View {
    // MARK: - View Params
    
    let model: User
    
    // MARK: - View Settings
    
    private let backgroundColor: Color = .init(white: 0.95)
    
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            avatarView
            nameAndLastOnlineView
            Spacer()
            infoView
        }
        .padding()
        .background(backgroundColor)
        .cornerRadius(12)
        .shadow(radius: 2)
        
    }
    
    // MARK: - Managing Subviews
    private var avatarView: some View {
        HStack {
            AsyncImage(url: model.photo)
                .scaledToFit()
                .frame(width: 48, height: 48)
                .clipShape(.rect(cornerRadius: .infinity))
                .overlay(alignment: .bottomTrailing) {
                    if model.isOnline {
                        OnlineIndicatorView(isBig: false,
                                            borderColor: backgroundColor,
                                            fromPhone: model.onlineMobile ?? false)
                    }
                }
        }
    }
    
    private var infoView: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let date = model.birthDate {
                TextInfoView(title: "Дата рождения:\n", value: DateFormatter.formattedDate(from: date))
            }
            
            if let city = model.city {
                TextInfoView(title: "г.", value: city)
            }
        }
    }
    
    private var nameAndLastOnlineView: some View {
        VStack(alignment: .leading) {
            Text(model.visibleName)
                .font(.caption)
                .bold()
            if !model.isOnline, let lastDate = model.lastSeen {
                let title = model.gender == .female ? "Была в сети:" : "Был в сети:"
                TextInfoView(title: title, value: DateFormatter.lastSeenDate(from: lastDate))
            } else {
                TextInfoView(title: "", value: "В сети")
            }
        }
    }
}

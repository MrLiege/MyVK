//
//  ProfileInfoView.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 17.09.2024.
//

import SwiftUI

struct ProfileInfoView: View {
    let model: User
    
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 8) {
                AsyncImage(url: model.photoBig)
                    .aspectRatio(contentMode: .fill)
                    .frame(width: Constants.imageSize, height: Constants.imageSize)
                    .clipShape(.rect(cornerRadius: 15))
                    .overlay(alignment: .bottomTrailing) {
                        if model.isOnline {
                            OnlineIndicatorView(isBig: true, borderColor: .white, fromPhone: model.onlineMobile ?? false)
                                .padding(.bottom, -5)
                        }
                    }
            }
            VStack {
                infoView
                infoAboutUserView
            }
        }
        .padding(.bottom, 4)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

extension ProfileInfoView {
    @ViewBuilder
    var infoView: some View {
        VStack(alignment: .leading) {
            Text(model.visibleName)
                .font(.title2)
                .bold()
            
            if !model.isOnline, let lastDate = model.lastSeen {
                let title = model.gender == .female ? "Была в сети:" : "Был в сети:"
                TextInfoView(title: title, value: DateFormatter.lastSeenDate(from: lastDate))
            } else {
                TextInfoView(title: "", value: "В сети")
            }
        }
    }
    
    @ViewBuilder
    var infoAboutUserView: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let domain = model.domain {
                TextInfoView(title: "ID: ", value: domain)
            }
            
            if let city = model.city {
                TextInfoView(title: "Город:", value: city)
            }
            
            if let birthDate = model.birthDate {
                TextInfoView(title: "Дата рождения:", value: birthDate)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(12)
    }
}

private enum Constants {
    static let imageSize: Double = 144
}

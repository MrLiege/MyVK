//
//  CommunitiesListView.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 23.09.2024.
//

import SwiftUI

struct CommunitiesListView: View {
    
    let model: Community
    
    var body: some View {
        VStack(alignment: .leading ,spacing: 8) {
            photoCommunView
            nameAndType
            
        }
        .background(Color(.systemGray5))
        .cornerRadius(15)
        .shadow(radius: 1)
    }
}

extension CommunitiesListView {
    @ViewBuilder
    var photoCommunView: some View {
        AsyncImage(url: model.photoBig) { phase in
            switch phase {
            case .empty:
                ProgressView()
                    .frame(width: Constants.imageSize, height: Constants.imageSize)
            case .success(let image):
                image
                    .resizable()
                    .scaledToFill()
                    .frame(width: Constants.imageSize, height: Constants.imageSize)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .overlay(alignment: .bottomLeading) {
                        subscribersText
                            .padding()
                    }
            case .failure:
                Image(systemName: "photo.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(width: Constants.imageSize, height: Constants.imageSize)
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .overlay(alignment: .bottomLeading) {
                        subscribersText
                    }
            @unknown default:
                EmptyView()
            }
        }
    }
    
    @ViewBuilder
    var subscribersText: some View {
        Text((model.membersCount ?? 0).formattedSubscribers())
            .font(.caption)
            .foregroundColor(.white)
            .padding(8)
            .lineLimit(1)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.ultraThinMaterial)
            )
    }
    
    @ViewBuilder
    var nameAndType: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(model.name ?? "")
                .font(.caption)
                .bold()
                .lineLimit(1)
            
            Text(model.activity ?? "")
                .font(.caption)
                .foregroundStyle(Color.gray)
                .lineLimit(1)
        }
        .padding()
    }
}

private enum Constants {
    static let imageSize: Double = 150
}

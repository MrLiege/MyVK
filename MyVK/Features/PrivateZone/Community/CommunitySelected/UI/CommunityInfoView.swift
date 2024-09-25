//
//  CommunityInfoView.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 24.09.2024.
//

import SwiftUI

struct CommunityInfoView: View {
    
    let model: Community
    
    var body: some View {
        VStack() {
            mainInfoView
                .background(Color(.systemGray5))
                .cornerRadius(15)
                .offset(y: Constants.offsetY)
        }
        .coverBackground(cover: model.cover, heightSize: Constants.coverHeightSize)
    }
}

private extension CommunityInfoView {
    @ViewBuilder
    var mainInfoView: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let photoBigURL = model.photoBig {
                AsyncImage(url: photoBigURL) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: Constants.photoSize, height: Constants.photoSize)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color(.systemGray2), lineWidth: 4))
                } placeholder: {
                    ProgressView()
                        .frame(width: Constants.photoSize, height: Constants.photoSize)
                }
            }
            Text(model.name ?? "")
                .font(.title2)
                .bold()
            
            HStack {
                Image(systemName: model.isClosed == 1 ? "lock" : "lock.open")
                    .aspectRatio(contentMode: .fit)
                    .controlSize(.small)
                    .symbolRenderingMode(.multicolor)
                    .foregroundColor(Color.gray)
                Text((model.membersCount ?? 0).formattedSubscribers())
                    .font(.caption)
                    .foregroundStyle(Color.gray)
            }
        }
        .padding()
        .background(Color(.systemGray5))
        .cornerRadius(15)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

private enum Constants {
    static let offsetY: Double = 171
    static let coverHeightSize: Double = 190
    static let photoSize: Double = 100
}

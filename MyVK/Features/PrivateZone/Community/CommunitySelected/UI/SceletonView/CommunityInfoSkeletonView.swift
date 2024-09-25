//
//  CommunityInfoSkeletonView.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 25.09.2024.
//

import SwiftUI

struct CommunityInfoSkeletonView: View {
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 8) {
                ShimmerView()
                    .frame(width: Constants.photoSize, height: Constants.photoSize)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color(.systemGray2), lineWidth: 4))
                
                ShimmerView()
                    .frame(height: 24)
                    .cornerRadius(4)
                
                HStack {
                    ShimmerView()
                        .frame(width: 20, height: 20)
                        .cornerRadius(4)
                    ShimmerView()
                        .frame(height: 20)
                        .cornerRadius(4)
                }
            }
            .padding()
            .background(Color(.systemGray5))
            .cornerRadius(15)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .background(Color(.systemGray5))
        .cornerRadius(15)
        .offset(y: Constants.offsetY)
    }
}

private enum Constants {
    static let offsetY: Double = 171
    static let coverHeightSize: Double = 190
    static let photoSize: Double = 100
}

#Preview {
    CommunityInfoSkeletonView()
}

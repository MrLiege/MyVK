//
//  FriendsSceletonView.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 15.09.2024.
//

import SwiftUI

struct FriendsSceletonView: View {
    var body: some View {
        HStack(alignment: .top, spacing: 8) {
            ShimmerView()
                .frame(width: 48, height: 48)
                .clipShape(Circle())
                .shadow(radius: 2)
            
            vStackSceleton
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            vStackSceleton
        }
        .padding()
        .background(Color(white: 0.95))
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

private extension FriendsSceletonView {
    @ViewBuilder
    var vStackSceleton: some View {
        VStack(alignment: .leading, spacing: 8) {
            ShimmerView()
                .frame(height: 20)
                .cornerRadius(4)
                .shadow(radius: 2)
            
            ShimmerView()
                .frame(height: 16)
                .cornerRadius(4)
                .shadow(radius: 2)
            
            ShimmerView()
                .frame(height: 16)
                .cornerRadius(4)
                .shadow(radius: 2)
        }
    }
}

#Preview {
    FriendsSceletonView()
}

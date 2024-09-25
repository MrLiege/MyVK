//
//  CommunitiesListSceletonView.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 25.09.2024.
//

import SwiftUI

struct CommunitiesListSceletonView: View {
    var body: some View {
        ScrollView(.vertical) {
            LazyVGrid(columns: Constants.gridItems, alignment: .center, spacing: 10) {
                ForEach(0..<4) { _ in
                    communityCell
                        .frame(
                            maxWidth: Constants.gridWidthSize,
                            maxHeight: Constants.gridHeightSize
                        )
                }
            }
            .padding(.vertical, 100)
        }
    }
}

private extension CommunitiesListSceletonView {
    @ViewBuilder
    var communityCell: some View {
        VStack(alignment: .leading, spacing: 8) {
            ShimmerView()
                .frame(width: Constants.imageSize, height: Constants.imageSize)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                .shadow(radius: 2)
            VStack() {
                ShimmerView()
                    .frame(height: 20)
                    .cornerRadius(4)
                    .shadow(radius: 2)
                
                ShimmerView()
                    .frame(height: 15)
                    .cornerRadius(4)
                    .shadow(radius: 2)
            }
            .padding()
        }
        .background(Color(white: 0.95))
        .cornerRadius(15)
        .shadow(radius: 1)
    }
}

private enum Constants {
    static let imageSize: Double = 150
    static let gridWidthSize = (UIScreen.main.bounds.width - 90) / 2
    static let gridHeightSize = (UIScreen.main.bounds.height - 100) / 3
    static let gridItems: [GridItem] = Array(repeating: .init(.fixed(gridWidthSize)), count: 2)
}

#Preview {
    CommunitiesListSceletonView()
}

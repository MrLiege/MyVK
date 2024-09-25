//
//  GridItemPhotoSceletonView.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 19.09.2024.
//

import SwiftUI

struct GridItemPhotoSceletonView: View {
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Constants.gridItems, alignment: .center, spacing: 2) {
                ForEach(0..<15) { _ in
                    ShimmerView()
                        .frame(width: Constants.gridSize, height: Constants.gridSize)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .shadow(radius: 2)
                }
            }
            .padding(.vertical, 100)
        }
    }
}

private enum Constants {
    static let gridSize = (UIScreen.main.bounds.width - 32 - 20) / 3
    static let gridItems: [GridItem] = Array(repeating: .init(.fixed(gridSize)), count: 3)
}

#Preview {
    GridItemPhotoSceletonView()
}

//
//  PhotoView.swift
//  MyVK
//
//  Created by Artyom Petrichenko on 19.09.2024.
//

import SwiftUI
import ComposableArchitecture

struct PhotoView: View {
    
    @Bindable var store: StoreOf<PhotoFeature>
    
    var body: some View {
        LoadableView(store: store.scope(
            state: \.loadableView,
            action: \.loadableView)) {
                ScrollView {
                    LazyVGrid(columns: Constants.gridItems, alignment: .center, spacing: 2) {
                        ForEach(store.photos) { model in
                            AsyncImage(url: model.url) { phase in
                                if let image = phase.image {
                                    image
                                        .resizable()
                                        .aspectRatio(contentMode: .fill)
                                        .frame(width: Constants.gridSize, height: Constants.gridSize)
                                        .clipped()
                                        .clipShape(RoundedRectangle(cornerRadius: 8))
                                } else {
                                    ProgressView()
                                        .frame(width: Constants.gridSize, height: Constants.gridSize)
                                }
                            }
                        }
                    }
                    .padding()
                }
        } skeleton: {
            ProfileSceletonView()
        }
        .navigationTitle("Фото профиля")
        .onAppear(perform: appearAction)
    }
}

private extension PhotoView {
    func appearAction() {
        store.send(.onAppear)
    }
}

private enum Constants {
    static let gridSize = (UIScreen.main.bounds.width - 32 - 20) / 3
    static let gridItems: [GridItem] = Array(repeating: .init(.fixed(gridSize)), count: 3)
}
